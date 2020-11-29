//
//  AppNetworking.swift
//  StarterProj
//
//  Created by Admin on 16/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Photos

typealias JSONDictionary = [String: Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias HTTPHeaders = [String: String]
typealias SuccessResponse = (_ json: JSON) -> Void
typealias FailureResponse = (Error) -> Void
typealias FailureResponseWithStatusCode = (Error, Int) -> Void
typealias ResponseMessage = (_ message: String) -> Void
typealias JSONDict = [String: Any]

extension Notification.Name {
    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

enum JSONType {
    case jsonDict
    case arrJSON
}

enum AppNetworking {
    static var timeOutInterval = TimeInterval(35)
    static var userName = ""
    static var password = ""
    static var passwordSeparator = "**********"
    static func isConnected() -> Bool {
        do {
          return try Reachability().connection != .unavailable
        } catch {
            return false
        }
    }

    private static func executeRequest(jsonType: JSONType = .jsonDict, _ request: NSMutableURLRequest, _ success: @escaping (JSON) -> Void, _ failure: @escaping (Error) -> Void) {
        let session = URLSession.shared
        
        session.configuration.timeoutIntervalForRequest = timeOutInterval
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if error == nil {
                
                do {
                    switch jsonType {
                    case .jsonDict:
                        if let jsonData = data {
                            
                            if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                                
                                printDebug(jsonDataDict)
                                if let httpResponse = response as? HTTPURLResponse {
                                    printDebug("httpResponse.statusCode :\(httpResponse.statusCode)")
                                    
                                    switch httpResponse.statusCode {
                                    case ApiCode.success, ApiCode.created:
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            
                                            success(JSON(jsonDataDict))
                                        })
                                    case ApiCode.unAuthorized:
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            CommonFunctions.showToastWithMessage(StringConstant.sessionExpired.value)
                                        })
                                    default:
                                        let error = NSError.init(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: JSON(jsonDataDict)[ApiKey.message].stringValue])
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            failure(error)
                                        })
                                    }
                                }
                                
                            }
                            
                        } else {
                            let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data found"])
                            failure(error)
                        }
                        
                    case .arrJSON:
                        if let jsonData = data {
                            
                            if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String: Any]] {
                                
                                printDebug(jsonDataDict)
                                if let httpResponse = response as? HTTPURLResponse {
                                    printDebug("httpResponse.statusCode :\(httpResponse.statusCode)")
                                    
                                    switch httpResponse.statusCode {
                                    case ApiCode.success, ApiCode.created:
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            
                                            success(JSON(jsonDataDict))
                                        })
                                    case ApiCode.unAuthorized:
                                        DispatchQueue.main.async(execute: { () -> Void in
                                        })
                                    default:
                                        let error = NSError.init(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: JSON(jsonDataDict)[ApiKey.message].stringValue])
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            failure(error)
                                        })
                                    }
                                }
                                
                            }
                            
                        } else {
                            let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data found"])
                            failure(error)
                        }
                    }
                } catch let err as NSError {
                    
                    let responseString = String(data: data!, encoding: .utf8)
                    printDebug("responseString = \(responseString ?? "")")
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        failure(err)
                    })
                }
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    printDebug(httpResponse)
                }
                if let err = error {
                    DispatchQueue.main.async(execute: { () -> Void in
                        failure(err)
                    })
                } else {
                    let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
                    failure(error)
                }
            }
        })
        
        dataTask.resume()
    }
    
    fileprivate static func checkRefereshTokenAndExecute(_ request: NSMutableURLRequest, _ loader: Bool, _ success: @escaping (JSON) -> Void, _ failure: @escaping (Error) -> Void) {
        executeRequest(request, { (json) in
            if loader { CommonFunctions.hideActivityLoader() }
            
            let code = json[ApiKey.code].intValue
            if code == ApiCode.unAuthorized {
                //                WebServices.refreshToken(success: { (json) in
                //                    executeRequest(request, success, failure)
                //                }, failure: failure)
            } else {
                success(json)
            }
        }, { (err) in
            if loader { CommonFunctions.hideActivityLoader() }
            failure(err)
        })
    }
    
    private static func REQUEST(withUrl url: URL?, jsonType: JSONType = .jsonDict, method: String, postData: Data?, header: [String: String], loader: Bool, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void) {
        
        guard let url = url else {
            let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Url or parameters not valid"])
            failure(error)
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: timeOutInterval)
        request.httpMethod = method
        
        var updatedHeaders = header
        if isUserLoggedin {
            let strToken: String = AppUserDefaults.value(forKey: .accesstoken).stringValue
            if !strToken.isEmpty {
                updatedHeaders[ApiKey.authorization] =  "Bearer \(strToken)"
            }
        }
        let typeOfUser = AppUserDefaults.value(forKey: .userType).intValue
        let str = CommonFunctions.convertToApiFormat([ApiKey.type: "\(typeOfUser)", ApiKey.deviceId: DeviceDetail.deviceId, ApiKey.token: DeviceDetail.deviceToken])
        updatedHeaders[ApiKey.deviceDetails] = str
        updatedHeaders[ApiKey.lang] =  AppUserDefaults.value(forKey: .language).stringValue

        request.allHTTPHeaderFields = updatedHeaders
        request.httpBody = postData
        if loader { CommonFunctions.showActivityLoader() }
        
        printDebug("================API URL================")
        printDebug(url)
        printDebug("================HEADER=================")
        printDebug(updatedHeaders)
        printDebug("================httpBody===============")
        printDebug(postData)
        executeRequest(jsonType: jsonType, request, { (json) in
            if loader { CommonFunctions.hideActivityLoader()}
            success(json)
        }, { (err) in
            if loader { CommonFunctions.hideActivityLoader() }
            failure(err)
        })
    }
    
    private static func REQUESTWithCustomHeader(withUrl url: URL?, jsonType: JSONType = .jsonDict, method: String, postData: Data?, header: [String: String], loader: Bool, requireAccesstoken: Bool = true, success: @escaping (JSON) -> Void, failure: @escaping (Error) -> Void) {
        
        guard let url = url else {
            let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Url or parameters not valid"])
            failure(error)
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: timeOutInterval)
        request.httpMethod = method
                        
        request.allHTTPHeaderFields = header
        request.httpBody = postData
        if loader { CommonFunctions.showActivityLoader() }
        
        printDebug("================API URL================")
        printDebug(url)
        printDebug("================HEADER=================")
        printDebug(header)
        printDebug("================httpBody===============")
        printDebug(postData)
        executeRequest(jsonType: jsonType, request, { (json) in
            if loader { CommonFunctions.hideActivityLoader()}
            success(json)
        }, { (err) in
            if loader { CommonFunctions.hideActivityLoader() }
            failure(err)
        })
    }
    
    static func GET(endPoint: String,
                    parameters: [String: Any] = [:],
                    headers: HTTPHeaders = [:],
                    loader: Bool = true,
                    success: @escaping (JSON) -> Void,
                    failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("=======================================")
        
        var updatedHeaders = headers
        updatedHeaders[ApiKey.contentType] =  "application/json; charset=utf-8"
        updatedHeaders[ApiKey.accept] =  "application/json"
        
        guard let urlString = (endPoint + "?" + encodeParamaters(params: parameters)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        let uri = URL(string: urlString)
        
        REQUEST(withUrl: uri,
                method: "GET",
                postData: nil,
                header: updatedHeaders,
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func GETWithoutHeaders(endPoint: String,
                                  parameters: [String: Any] = [:],
                                  loader: Bool = true,
                                  jsonType: JSONType = .jsonDict,
                                  success: @escaping (JSON) -> Void,
                                  failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("=======================================")
        
        guard let urlString = (endPoint + "?" + encodeParamaters(params: parameters)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        let uri = URL(string: urlString)
        
        REQUEST(withUrl: uri,
                jsonType: jsonType,
                method: "GET",
                postData: nil,
                header: [:],
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func GETWithCustomHeaders(header: HTTPHeaders,
                                     endPoint: String,
                                     parameters: [String: Any] = [:],
                                     loader: Bool = true,
                                     jsonType: JSONType = .jsonDict,
                                     success: @escaping (JSON) -> Void,
                                     failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("=======================================")
        
        guard let urlString = (endPoint + "?" + encodeParamaters(params: parameters)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        let uri = URL(string: urlString)
        
        REQUESTWithCustomHeader(withUrl: uri,
                jsonType: jsonType,
                method: "GET",
                postData: nil,
                header: header,
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func POST(endPoint: String,
                     parameters: [String: Any] = [:],
                     headers: HTTPHeaders = [:],
                     loader: Bool = true,
                     success: @escaping (JSON) -> Void,
                     failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("=======================================")
        
        printDebug("=======================================")
        printDebug("===============ENDPOINT==============")
        printDebug(endPoint)
        printDebug("=======================================")
        
        let uri = URL(string: endPoint)
        
        //let postData = encodeParamaters(params: parameters).data(using: String.Encoding.utf8)
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters)
        
        var updatedHeaders = headers
        updatedHeaders[ApiKey.contentType] =  "application/json; charset=utf-8"
        updatedHeaders[ApiKey.accept] =  "application/json"
                
        REQUEST(withUrl: uri,
                method: "POST",
                postData: postData,
                header: updatedHeaders,
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func POSTWithoutHeaders(endPoint: String,
                                   parameters: [String: Any] = [:],
                                   headers: HTTPHeaders = [:],
                                   loader: Bool = true,
                                   success: @escaping (JSON) -> Void,
                                   failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("=======================================")
        
        printDebug("=======================================")
        printDebug("===============ENDPOINT==============")
        printDebug(endPoint)
        printDebug("=======================================")
        
        let uri = URL(string: endPoint)
        
        //let postData = encodeParamaters(params: parameters).data(using: String.Encoding.utf8)
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters)
        
        REQUEST(withUrl: uri,
                method: "POST",
                postData: postData,
                header: [:],
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func POSTWithImage(endPoint: String,
                              parameters: [String: Any] = [:],
                              image: [String: UIImage] = [:],
                              headers: HTTPHeaders = [:],
                              loader: Bool = true,
                              success: @escaping (JSON) -> Void,
                              failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("=======================================")
        
        let uri = URL(string: endPoint)
        
        let boundary = generateBoundary()
        let postData = createDataBody(withParameters: parameters, media: image, boundary: boundary)
        var updatedHeader = headers
        
        updatedHeader["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        updatedHeader[ApiKey.accept] =  "application/json"
        
        REQUEST(withUrl: uri,
                method: "POST",
                postData: postData,
                header: updatedHeader,
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func PATCH(endPoint : String,
                      parameters : [String : Any] = [:],
                      headers : HTTPHeaders = [:],
                      loader : Bool = false,
                      success : @escaping (JSON) -> Void,
                      failure : @escaping (Error) -> Void) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        let postData = try? JSONSerialization.data(withJSONObject: parameters)
        var updatedHeaders = headers
        updatedHeaders[ApiKey.contentType] =  "application/json; charset=utf-8"
        updatedHeaders[ApiKey.accept] =  "application/json"
        REQUEST(withUrl: uri,
                method: "PATCH",
                postData : postData,
                header: updatedHeaders,
                loader: loader,
                success: success,
                failure: failure)
        
    }
    
    static func PUTWithImage(endPoint: String,
                              parameters: [String: Any] = [:],
                              image: [String: UIImage] = [:],
                              headers: HTTPHeaders = [:],
                              loader: Bool = true,
                              success: @escaping (JSON) -> Void,
                              failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("=======================================")
        
        let uri = URL(string: endPoint)
        
        let boundary = generateBoundary()
        let postData = createDataBody(withParameters: parameters, media: image, boundary: boundary)
        var updatedHeader = headers
        
        updatedHeader["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        updatedHeader[ApiKey.accept] =  "application/json"
        
        REQUEST(withUrl: uri,
                method: "PUT",
                postData: postData,
                header: updatedHeader,
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func POSTWithDocument(endPoint: String,
                                 parameters: [String: Any] = [:],
                                 document: [String: String] = [:],
                                 headers: HTTPHeaders = [:],
                                 loader: Bool = true,
                                 success: @escaping (JSON) -> Void,
                                 failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("===============DOCUMENT==============")
        printDebug(document)
        printDebug("=======================================")
        
        let uri = URL(string: endPoint)
        
        let boundary = generateBoundary()
        let postData = createDataBodyForDocument(withParameters: parameters, media: document, boundary: boundary)
        var updatedHeader = headers
        
        updatedHeader["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        updatedHeader[ApiKey.accept] =  "application/json"
        
        REQUEST(withUrl: uri,
                method: "POST",
                postData: postData,
                header: updatedHeader,
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func PUTWithDocument(endPoint: String,
                                 parameters: [String: Any] = [:],
                                 document: [String: String] = [:],
                                 headers: HTTPHeaders = [:],
                                 loader: Bool = true,
                                 success: @escaping (JSON) -> Void,
                                 failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("===============DOCUMENT==============")
        printDebug(document)
        printDebug("=======================================")
        
        let uri = URL(string: endPoint)
        
        let boundary = generateBoundary()
        let postData = createDataBodyForDocument(withParameters: parameters, media: document, boundary: boundary)
        var updatedHeader = headers
        
        updatedHeader["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        updatedHeader[ApiKey.accept] =  "application/json"
        
        REQUEST(withUrl: uri,
                method: "PUT",
                postData: postData,
                header: updatedHeader,
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func PUT(endPoint: String,
                    parameters: [String: Any] = [:],
                    headers: HTTPHeaders = [:],
                    loader: Bool = true,
                    success: @escaping (JSON) -> Void,
                    failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("=======================================")
        
        let uri = URL(string: endPoint)
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters)
        
        var updatedHeaders = headers
        updatedHeaders[ApiKey.contentType] =  "application/json; charset=utf-8"
        updatedHeaders[ApiKey.accept] =  "application/json"
        
        REQUEST(withUrl: uri,
                method: "PUT",
                postData: postData,
                header: updatedHeaders,
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static func DELETE(endPoint: String,
                       parameters: [String: Any] = [:],
                       headers: HTTPHeaders = [:],
                       loader: Bool = true,
                       success: @escaping (JSON) -> Void,
                       failure: @escaping (Error) -> Void) {
        
        printDebug("=======================================")
        printDebug("===============PARAMETERS==============")
        printDebug(parameters)
        printDebug("=======================================")
        
        let uri = URL(string: endPoint)
        
//        let postData = encodeParamaters(params: parameters).data(using: String.Encoding.utf8)
        let postData = try? JSONSerialization.data(withJSONObject: parameters)

        var updatedHeaders = headers
        updatedHeaders[ApiKey.contentType] =  "application/json; charset=utf-8"
        updatedHeaders[ApiKey.accept] =  "application/json"
        
        REQUEST(withUrl: uri,
                method: "DELETE",
                postData: postData,
                header: updatedHeaders,
                loader: loader,
                success: success,
                failure: failure)
    }
    
    static private func encodeParamaters(params: [String: Any]) -> String {
        
        var result = ""
        
        for key in params.keys {
            
            result.append(key+"=\(params[key] ?? "")&")
            
        }
        
        if !result.isEmpty {
            result.remove(at: result.index(before: result.endIndex))
        }
        
        return result
    }
    
    static func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    static func createDataBody(withParameters params: [String: Any]?, media: [String: UIImage]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)\(lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media.keys {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo)\"; filename=\" image.jpg\"\(lineBreak)")
                body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
                
                let data = media[photo]!.jpegData(compressionQuality: 0.7)
                body.append(data!)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
    static func createDataBodyForDocument(withParameters params: [String: Any]?, media: [String: String]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)\(lineBreak)")
            }
        }
        if let media = media {
            for photo in media.keys {
                guard let documentURL = URL(string: media[photo]!) else {continue}
                
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo)\"; filename=\" \(documentURL.lastPathComponent)\"\(lineBreak)")
                body.append("Content-Type: document/\(documentURL.pathExtension)\(lineBreak + lineBreak)")
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: media[photo]!))
                    body.append(data)
                    body.append(lineBreak)
                    
                } catch {
                    
                }
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
    
    static func createDataBodyForVideo(withParameters params: [String: Any]?, media: [String: URL]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)\(lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media.keys {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo)\"; filename=\" image.mp4\"\(lineBreak)")
                body.append("Content-Type: video/mp4\(lineBreak + lineBreak)")
                do {
                    let data = try Data(contentsOf: media[photo]! as URL)
                    body.append(data)
                    body.append(lineBreak)
                } catch {
                    
                }
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
}

extension Data {
    /// Append string to NSMutableData
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    /// - parameter string:       The string to be added to the `NSMutableData`.
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
