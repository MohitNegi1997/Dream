//
//  CommonClasses.swift
//  DittoFashionMarketBeta
//
//  Created by Advisor on 23/11/17.
//  Copyright © 2017 Advisor. All rights reserved.
//

import UIKit
import Toaster
import NVActivityIndicatorView
import MobileCoreServices
import AVFoundation
import AVKit

class CommonFunctions {
    
    /// Show Toast With Message
    static func showToastWithMessage(_ msg: String, completion: (() -> Swift.Void)? = nil) {
        DispatchQueue.mainQueueAsync {
            ToastView.appearance().font = AppFonts.NunitoSansRegular.withSize(14)
            ToastView.appearance().textColor = AppColors.white
            ToastView.appearance().backgroundColor = AppColors.black
        
            if msg.count > 60 {
                let toast = Toast(text: msg, delay: 0.3, duration: 5)
                toast.show()
            } else {
            let toast = Toast(text: msg, delay: 0.3, duration: 0.7)
                toast.show()
            }
        }
    }
    
    /// Delay Functions
    class func delay(delay: Double, closure:@escaping () -> Void) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when) {
            closure()
            
        }
    }
    
    class func getDeviceIsIphn(){
        let deviceIdeom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch (deviceIdeom) {
        case .pad:
            deviceType = .iPad
        default:
            deviceType = .iPhone
        }
    }
    
    /// Show Action Sheet With Actions Array
    class func showActionSheetWithActionArray(_ title: String?, message: String?,
                                              viewController: UIViewController,
                                              alertActionArray: [UIAlertAction],
                                              preferredStyle: UIAlertController.Style) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alertActionArray.forEach { alert.addAction($0) }
        
        DispatchQueue.mainQueueAsync {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Show Activity Loader
    class func showActivityLoader() {
        DispatchQueue.mainQueueAsync {
            if let vc = AppDelegate.shared.window?.rootViewController {
                vc.startNYLoader()
            }
        }
    }
    
    /// Hide Activity Loader
    class func hideActivityLoader() {
        DispatchQueue.mainQueueAsync {
            if let vc = AppDelegate.shared.window?.rootViewController {
                vc.stopAnimating()
            }
        }
    }
    
    /// Show Action Sheet With Actions Array
    class func showActivityViewController(_ content: [Any],
                                          viewController: UIViewController) {
        let activityViewController = UIActivityViewController(activityItems: content, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController.view
        
        DispatchQueue.mainQueueAsync {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }

    
    class func openMapForLocation(lat: String, long: String) {
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            let urlString = "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving"
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            let urlString = "http://maps.apple.com/?daddr=\(lat),\(long)&saddr="
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    class func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    class func convertURLToData(url: URL) -> Data {
        do {
            let data = try Data.init(contentsOf: url)
            return data
        } catch {
            printDebug(error.localizedDescription)
            printDebug("Error: Cannot convert to data")
        }
        return Data()
    }
    
    class func alertActionWithBlueDone(title: String = "Advisor", doneTitle: String, msg : String,
                                       selfVC : UIViewController,completion: (()->())? = nil) {
         
         let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
         
         let titleFont = [NSAttributedString.Key.font: AppFonts.NunitoSansSemiBold.withSize(20)]
         let messageFont = [NSAttributedString.Key.font: AppFonts.NunitoSansSemiBold.withSize(16)]
         
         let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
         let messageAttrString = NSMutableAttributedString(string: msg, attributes: messageFont)
         
         alertController.setValue(titleAttrString, forKey: "attributedTitle")
         alertController.setValue(messageAttrString, forKey: "attributedMessage")
         let action = UIAlertAction(title: doneTitle, style: UIAlertAction.Style.destructive) { (_) in
             completion?()
         }
         
         action.setValue(UIColor.red, forKey: "titleTextColor")
         alertController.addAction(action)
         selfVC.present(alertController, animated: true, completion: nil)
     }
    
    static func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
          print(error.localizedDescription)
          return nil
        }
    }
    
    static func convertToApiFormat(_ dict : [String : Any]) -> String {
        
        var data = Data()
        
        do {
            data = try JSONSerialization.data(
                withJSONObject: dict ,
                options: JSONSerialization.WritingOptions(rawValue: 0))
        }
        catch{
            
            print("Something went wrong when converting array")
        }
        
        if let tempString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String?{
            
            return tempString
        }else{
            
            return ""
        }
    }
}
