//
//  AppFonts.swift
//  DannApp
//
//  Created by Aakash Srivastav on 20/04/17.
//  Copyright © 2017 Advisor. All rights reserved.
//

import Foundation
import UIKit

enum AppFonts: String {
    case NunitoSansBlack = "NunitoSans-Black"
    case NunitoSansBlackItalic = "NunitoSans-BlackItalic"
    case NunitoSansBold = "NunitoSans-Bold"
    case NunitoSansBoldItalic = "NunitoSans-BoldItalic"
    case NunitoSansExtraBold = "NunitoSans-ExtraBold"
    case NunitoSansExtraBoldItalic = "NunitoSans-ExtraBoldItalic"
    case NunitoSansExtraLight = "NunitoSans-ExtraLight"
    case NunitoSansExtraLightItalic = "NunitoSans-ExtraLightItalic"
    case NunitoSansItalic = "NunitoSans-Italic"
    case NunitoSansLight = "NunitoSans-Light"
    case NunitoSansLightItalic = "NunitoSans-LightItalic"
    case NunitoSansRegular = "NunitoSans-Regular"
    case NunitoSansSemiBold = "NunitoSans-SemiBold"
    case NunitoSansSemiBoldItalic = "NunitoSans-SemiBoldItalic"
}

extension AppFonts {
    func withSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    func withDefaultSize() -> UIFont {
        return UIFont(name: self.rawValue, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    }

}
