//
//  Globals.swift
//  Onboarding
//
//  Created by Advisor on 22/08/16.
//  Copyright © 2016 Advisor Singh. All rights reserved.
//

import Foundation
import UIKit

/// Print Debug
func printDebug<T>(_ obj: T) {
    #if DEBUG
        print(obj)
    #endif
}

/// Is Simulator or Device
var isSimulatorDevice: Bool {

    var isSimulator = false
    #if arch(i386) || arch(x86_64)
        //simulator
        isSimulator = true
    #endif
    return isSimulator
}

/// Is this iPhone X or not
func isDeviceIsIphoneX() -> Bool {
    let device: UIDevice = UIDevice()
    if device.userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return false
        case 1334: return false
        case 2208: return false
        case 2436: return true
        default: return false
        }
    }
    return false
}

///checking Iphone model to set navigation bar bounds
func checkIsIphoneXOrGreater() -> Bool {
    switch UIScreen.main.nativeBounds.height {
    case 1136:
        return false
    case 1334:
        return false
    case 1920, 2208:
        return false
    case 2436:
        return true
    case 2688:
        return true
    case 1792:
        return true
    default:
        return false
    }
}

func suffixNumber(number: Double) -> String {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 2
    formatter.numberStyle = .decimal

    var num: Double = number
    let sign = ((num < 0) ? "-" : "" )

    num = fabs(num)

    if num < 1000.0 {
        let stringNum = formatter.string(from: num as NSNumber)
        return "\(sign)\(stringNum ?? "0")"
    }

    let exp: Int = Int(log10(num) / 3.0 ) //log10(1000));

    let units: [String] = ["K", "M", "B", "T", "Q", "E"]

    let roundedNum: Double = round(10 * num / pow(1000.0, Double(exp))) / 10
    let stringNum = formatter.string(from: roundedNum as NSNumber)
    return "\(sign)\(stringNum ?? "0")\(units[exp-1])"
}

var isUserLoggedin: Bool {
    let token = AppUserDefaults.value(forKey: .accesstoken).stringValue
    if !token.isEmpty {
        return true
    } else {
        return false
    }
}

//device type
var deviceType: DeviceType = .iPhone

// for Language
var selectedLanguage =  AppUserDefaults.value(forKey: .language).stringValue


