//
//  AppConstants.swift
//
//  Created by Advisor on 10/08/18.
//  Copyright © 2018 Advisor. All rights reserved.
//

import Foundation

enum UploadType: String {
    case post = "post/source"
}

struct AppConstants {
    let rawValue: String
    static var defaultDate      = "0000-00-00"
    static var emptyString      = ""
    static var awss3PoolId = "us-east-1:b1f250f2-66a7-4d07-96e9-01817149a439"
    static var googlePlaceApiKey = "AIzaSyAmeRcKb4_NVo6ROBq9dwcqJfTydaGitdY"
    
    // for local keys
    static var iOSPlatform = AppConstants(rawValue: "2")
    static var androidPlatform = AppConstants(rawValue: "1")
    static var webPlatform = AppConstants(rawValue: "3")
}
