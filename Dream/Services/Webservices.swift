//
//  Webservices.swift
//  NewProject
//
//  Created by Admin   on 30/08/18.
//  Copyright © 2018 Admin  . All rights reserved.
//

import Foundation
import UIKit
enum WebServices { }

extension NSError {
    
    convenience init(localizedDescription: String) {
        self.init(domain: "AppNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
    
    convenience init(code: Int, localizedDescription: String) {
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}

extension WebServices {
    
    // MARK: - Common POST API
    //=======================
    static func commonPostAPI(parameters: JSONDictionary,
                              headers: HTTPHeaders = [:],
                              endPoint: EndPoint,
                              loader: Bool = true,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse) {
        
        AppNetworking.POST(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common URL APPENED Post API
    //=====================================================
    static func commonUrlAppendedPostAPI(value: String,
                                         parameters: JSONDictionary,
                                         headers: HTTPHeaders = [:],
                                         endPoint: EndPoint,
                                         loader: Bool = true,
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse) {
        
        AppNetworking.POST(endPoint: "\(endPoint.path)/\(value)", parameters: parameters, headers: headers, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    
    // MARK: - Common GET API
    //=======================
    static func commonGetAPI(parameters: JSONDictionary,
                             headers: HTTPHeaders = [:],
                             endPoint: EndPoint,
                             loader: Bool = false,
                             success: @escaping SuccessResponse,
                             failure: @escaping FailureResponse) {
        
        AppNetworking.GET(endPoint: endPoint.path, parameters: parameters, headers: headers, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.badRequest: success(json)
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common GET API For Third Party
    //===============================================
    static func commonGetCustomHeaderAPI(value: String = "",
                                         parameters: JSONDictionary,
                                         headers: HTTPHeaders = [:],
                                         endPoint: EndPoint,
                                         jsonType: JSONType = .jsonDict,
                                         loader: Bool = false,
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse) {
        
        AppNetworking.GETWithCustomHeaders(header: headers, endPoint: "\(endPoint.path)/\(value)", parameters: parameters, loader: loader, jsonType: jsonType, success: { (json) in
            printDebug(json)
            success(json)
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common URL APPENED GET API
    //==================================
    static func commonUrlAppendedGetAPI(value: String,
                                        parameters: JSONDictionary,
                                        endPoint: EndPoint,
                                        loader: Bool = true,
                                        success: @escaping SuccessResponse,
                                        failure: @escaping FailureResponse) {
        
        AppNetworking.GET(endPoint: "\(endPoint.path)/\(value)", parameters: parameters, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common PUT API
    //=======================
    static func commonPutAPI(parameters: JSONDictionary,
                             endPoint: EndPoint,
                             header: HTTPHeaders = [:],
                             loader: Bool = true,
                             success: @escaping SuccessResponse,
                             failure: @escaping FailureResponse) {
        AppNetworking.PUT(endPoint: endPoint.path, parameters: parameters, headers: header, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common URL APPENED Put API
    //==================================
    static func commonUrlAppendedPutAPI(value: String,
                                        parameters: JSONDictionary,
                                        endPoint: EndPoint,
                                        header: HTTPHeaders = [:],
                                        loader: Bool = true,
                                        success: @escaping SuccessResponse,
                                        failure: @escaping FailureResponse) {
        AppNetworking.PUT(endPoint: "\(endPoint.path)/\(value)", parameters: parameters, headers: header, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common DELETE API
    //=======================
    static func commonDeleteAPI(parameters: JSONDictionary,
                                endPoint: EndPoint,
                                header: HTTPHeaders = [:],
                                loader: Bool = true,
                                success: @escaping SuccessResponse,
                                failure: @escaping FailureResponse) {
        AppNetworking.DELETE(endPoint: endPoint.path, parameters: parameters, headers: header, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common URL APPENED Delete API
    //==================================
    static func commonUrlAppendedDeleteAPI(value: String,
                                           parameters: JSONDictionary,
                                           endPoint: EndPoint,
                                           header: HTTPHeaders = [:],
                                           loader: Bool = true,
                                           success: @escaping SuccessResponse,
                                           failure: @escaping FailureResponse) {
        AppNetworking.DELETE(endPoint: "\(endPoint.path)/\(value)", parameters: parameters, headers: header, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common POST With Document API
    //================================
    static func commonPostWithDocumentAPI(parameters: JSONDictionary,
                                          document: [String: String],
                                          headers: HTTPHeaders = [:],
                                          endPoint: EndPoint,
                                          loader: Bool = true,
                                          success: @escaping SuccessResponse,
                                          failure: @escaping FailureResponse) {
        
        AppNetworking.POSTWithDocument(endPoint: endPoint.path, parameters: parameters, document: document, headers: headers, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common Put With Document API
    //================================
    static func commonPutWithDocumentAPI(parameters: JSONDictionary,
                                         document: [String: String],
                                         headers: HTTPHeaders = [:],
                                         endPoint: EndPoint,
                                         loader: Bool = true,
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse) {
        
        AppNetworking.PUTWithDocument(endPoint: endPoint.path, parameters: parameters, document: document, headers: headers, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common API FOR Profile Upload
    //==================================
    static func commonPostWithImage(header: HTTPHeaders,
                                         parameters: JSONDictionary,
                                         loader: Bool,
                                         endPoint: EndPoint,
                                         image: [String: UIImage],
                                         success: @escaping SuccessResponse,
                                         failure: @escaping FailureResponse) {
        AppNetworking.POSTWithImage(endPoint: endPoint.path, parameters: parameters, image: image, headers: header, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK: - Common API FOR Company Upload Image
    //==================================
    static func commonPUTWithImage(header: HTTPHeaders,
                                                parameters: JSONDictionary,
                                                loader: Bool,
                                                endPoint: EndPoint,
                                                image: [String: UIImage],
                                                success: @escaping SuccessResponse,
                                                failure: @escaping FailureResponse) {
        AppNetworking.PUTWithImage(endPoint: endPoint.path, parameters: parameters, image: image, headers: header, loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success, ApiCode.created: success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }, failure: { (error) -> Void in
            failure(error)
        })
    }
    
    // MARK:- Common PATCH API
    //=======================
    static func commonPatchAPI(parameters: JSONDictionary,
                               headers: HTTPHeaders = [:],
                               endPoint: EndPoint,
                               loader: Bool = false,
                               success : @escaping SuccessResponse,
                               failure : @escaping FailureResponse) {
        
        AppNetworking.PATCH(endPoint: endPoint.path, parameters: parameters,  loader: loader, success: { (json) in
            let code = json[ApiKey.code].intValue
            let msg = json[ApiKey.message].stringValue
            switch code {
            case ApiCode.success: success(json)
            case 400 : success(json)
            default: failure(NSError(code: code, localizedDescription: msg))
            }
        }) { (error) in
            failure(error)
        }
    }
    
    // MARK:- Common PATCH API
       //=======================
    static func commonPatchUrlAppendedAPI(value: String,parameters: JSONDictionary,
                                  headers: HTTPHeaders = [:],
                                  endPoint: EndPoint,
                                  loader: Bool = false,
                                  success : @escaping SuccessResponse,
                                  failure : @escaping FailureResponse) {
           
           AppNetworking.PATCH(endPoint: "\(endPoint.path)/\(value)", parameters: parameters,  loader: loader, success: { (json) in
               let code = json[ApiKey.code].intValue
               let msg = json[ApiKey.message].stringValue
               switch code {
               case ApiCode.success: success(json)
               case 400 : success(json)
               default: failure(NSError(code: code, localizedDescription: msg))
               }
           }) { (error) in
               failure(error)
           }
       }
    
}

