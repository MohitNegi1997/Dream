//
//  BaseVC.swift
//  Advisor
//
//  Created by Admin on 13/05/20.
//  Copyright © 2020 AssetLock. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class BaseVC: UIViewController, UITextFieldDelegate {
    
    enum LeftNavType {
        case back, named, none, whiteBack, filter
    }
    enum NavBarType {
        case normal, lookUp, clearBackground, none
    }
    
    enum NoDataFoundCase {
        case noData
        case other
    }
    
    // MARK:- Variables
    //===================
    private var returnKeyHandler: IQKeyboardReturnKeyHandler?
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        
//        if #available(iOS 13.0, *) {
//            return UITraitCollection.current.userInterfaceStyle == .dark ? .lightContent : .darkContent
//        } else {
            // Fallback on earlier versions
            return .default //.default for black style
//        }
    }

    //MARK:- Life Cycle
    //===================
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        defaultSetup()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    deinit {
        printDebug("deinit")
        UserDefaults.standard.removeObject(forKey: "selectedDayStr")
    }

}

//MARK:- Extension for Methods
//=======================================
extension BaseVC {
    
    func defaultSetup() {
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
//                returnKeyHandler?.delegate = self
        returnKeyHandler?.lastTextFieldReturnKeyType = .done
    }
    
    @objc func bindViewModel() {
        
    }
}

//MARK:- Extension for Navigation Methods
//=======================================
extension BaseVC {
    
    //MARK:- SET NAVIGATION BAR Methods
    //=================================
    func setNavigationBar(withTitle title:String? = nil,
                          leftNavType: LeftNavType? = nil,
                          leftBtnTitle: String? = nil,
                          firstRightBtnImg:UIImage? = nil,
                          secRightBtnImg:UIImage? = nil,
                          thirdRightBtnImg:UIImage? = nil,
                          fourthRightBtnImg:UIImage? = nil,
                          firstRightBtnTitle:String? = nil,
                          secRightBtnTitle:String? = nil,
                          thirdRightBtnTitle:String? = nil,
                          fourthRightBtnTitle:String? = nil,
                          tintColor:UIColor? = nil,
                          barTintColor:UIColor? = nil,
                          attributesColor:UIColor? = nil, navBarType: NavBarType = .normal,
                          barStyle: UIBarStyle = .default,
                          leftBtnHandler: ((UIBarButtonItem) -> Void)? = nil) {
        
        //FOR LEFT BAR BUTTON
        var leftBtn = [UIBarButtonItem]()
        var firstRightBtn = UIBarButtonItem()
        var secRightBtn = UIBarButtonItem()
        var thirdRightBtn = UIBarButtonItem()
        var fourthRightBtn = UIBarButtonItem()
        
        if let lftNavType = leftNavType {
            if lftNavType == .back {
                if navBarType == .normal {
                    let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickBackNavigationBarButton(_:)))
                    leftBtn.append(backBtn)
                } else {
                    
                    let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickBackNavigationBarButton(_:)))
                    leftBtn.append(backBtn)
                }
            }
            else if lftNavType == .whiteBack {
                if navBarType == .normal {
                    let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickBackNavigationBarButton(_:)))
                    leftBtn.append(backBtn)
                } else {
                    let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickBackNavigationBarButton(_:)))
                    leftBtn.append(backBtn)
                }
            }
            else if lftNavType == .named {
                if navBarType == .clearBackground {
                    let backBtn = UIBarButtonItem(title: leftBtnTitle, style: UIBarButtonItem.Style.plain, target: self, action: nil)
                    backBtn.setTitleTextAttributes([NSAttributedString.Key.font : AppFonts.NunitoSansBold.withSize(deviceType == .iPhone ? 18 : 36), NSAttributedString.Key.foregroundColor: (AppColors.cerulean ?? .blue)], for: .normal)
                    leftBtn.append(backBtn)
                } else {
                    
                    let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickBackNavigationBarButton(_:)))
                    leftBtn.append(backBtn)
                }
            }
            else if lftNavType == .none {
                if navBarType == .clearBackground {
                    let backBtn = UIBarButtonItem()
                    leftBtn.append(backBtn)
                } else {
                    let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickBackNavigationBarButton(_:)))
                    leftBtn.append(backBtn)
                }
            }
        }
        
        //FOR FIRST RIGHT BAR BUTTON
        if let rightBtnImg = firstRightBtnImg {
            let btn: UIButton = UIButton()
            btn.setImage(rightBtnImg, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(onClickFirstRightNavigationBarButton(_:)), for: UIControl.Event.touchUpInside)
            btn.frame = CGRect(x: 0, y: 0, width: deviceType == .iPhone ? 30 : 60, height: deviceType == .iPhone ? 30 : 60)
            firstRightBtn = UIBarButtonItem(customView: btn)
        } else if let rightBtnTitle = firstRightBtnTitle {
            firstRightBtn = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(onClickFirstRightNavigationBarButton(_:)))
        }
        
        //FOR SECOND RIGHT BAR BUTTON
        if let rightBtnImg = secRightBtnImg {
            let btn: UIButton = UIButton()
            btn.setImage(rightBtnImg, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(onClickSecRightNavigationBarButton(_:)), for: UIControl.Event.touchUpInside)
            btn.frame = CGRect(x: 0, y: 0, width: deviceType == .iPhone ? 30 : 60, height: deviceType == .iPhone ? 30 : 60)
            secRightBtn = UIBarButtonItem(customView: btn)
        }else if let rightBtnTitle = secRightBtnTitle {
            secRightBtn = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(onClickSecRightNavigationBarButton(_:)))
        }
        
        //FOR THIRD RIGHT BAR BUTTON
        if let rightBtnImg = thirdRightBtnImg {
            let btn: UIButton = UIButton()
            btn.setImage(rightBtnImg, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(onClickThirdRightNavigationBarButton(_:)), for: UIControl.Event.touchUpInside)
            btn.frame = CGRect(x: 0, y: 0, width: deviceType == .iPhone ? 30 : 60, height: deviceType == .iPhone ? 30 : 60)
            thirdRightBtn = UIBarButtonItem(customView: btn)
        }else if let rightBtnTitle = thirdRightBtnTitle {
            thirdRightBtn = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(onClickThirdRightNavigationBarButton(_:)))
        }
        
        //FOR Fourth RIGHT BAR BUTTON
        if let rightBtnImg = fourthRightBtnImg {
            let btn: UIButton = UIButton()
            btn.setImage(rightBtnImg, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(onClickFourthRightNavigationBarButton(_:)), for: UIControl.Event.touchUpInside)
            btn.frame = CGRect(x: 0, y: 0, width: deviceType == .iPhone ? 30 : 60, height: deviceType == .iPhone ? 30 : 60)
            fourthRightBtn = UIBarButtonItem(customView: btn)
        }else if let rightBtnTitle = fourthRightBtnTitle {
            fourthRightBtn = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(onClickFourthRightNavigationBarButton(_:)))
        }
        
        let tColor = (tintColor == nil) ? (navBarType == .normal ? AppColors.black : UIColor.black) : tintColor
        
        
        let barTColor = (barTintColor == nil) ? (navBarType == .normal ? AppColors.cerulean : UIColor.white) : barTintColor
        
        let tAttributes = (attributesColor == nil) ? [
            NSAttributedString.Key.foregroundColor: tColor, NSAttributedString.Key.font: AppFonts.NunitoSansBold.withSize(deviceType == .iPhone ? 16 : 32)]:
            [
                NSAttributedString.Key.foregroundColor: attributesColor ?? tColor, NSAttributedString.Key.font: AppFonts.NunitoSansBold.withSize(deviceType == .iPhone ? 16 : 32)]
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = barStyle
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //    UIApplication.shared.statusBarStyle = .default
        
        if navBarType == .clearBackground {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = .clear
        }
        
        
        self.updateNavigationBar(withTitle: title,
                                 leftButton: leftBtn,
                                 rightButtons: [firstRightBtn,
                                                secRightBtn,
                                                thirdRightBtn,
                                                fourthRightBtn],
                                 tintColor: tColor,
                                 barTintColor: barTColor,
                                 titleTextAttributes: tAttributes as [NSAttributedString.Key : Any])
    }
    
    @objc func onClickBackNavigationBarButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickHomeNavigationBarButton(_ sender: UIButton) {
        
    }
    
    @objc func onClickFirstRightNavigationBarButton(_ sender: UIButton) {
        
    }
    
    @objc func onClickSecRightNavigationBarButton(_ sender: UIButton) {
        
    }
    
    @objc func onClickThirdRightNavigationBarButton(_ sender: UIButton) {
        
    }
    
    @objc func onClickFourthRightNavigationBarButton(_ sender: UIButton) {
        
    }
}

//MARK:- Extension for Textfield Delegate
//=======================================
extension BaseVC {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return  true
    }
}
