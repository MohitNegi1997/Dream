//
//  Webservice+EndPoints.swift
//
//  Created by Admin   on 30/08/18.
//  Copyright © 2018 Admin  . All rights reserved.
//

import Foundation

var baseUrl: String = "http://sigmaindiadev.appskeeper.com/api/v1/" // Development
//var baseUrl: String = "http://sigmaindiaqa.appskeeper.com/api/v1/" // QA
//var baseUrl: String = "http://sigmaindiastg.appskeeper.com/api/v1/" // Stg

var jobDetailUrl: String {
    return "http://sigmaindiadev.appskeeper.com/api/v1/jobs/deeplink/"
}

extension WebServices {
    //End points
    enum EndPoint: String {
        case login = "user/login"
        case logout = "user/logout"
        case signup = "user/signup"
        case resetPassword = "user/reset-password"
        case changePassword = "user/change-password"
        case forgotPassword = "user/forgot-password"
        case verifyOTP = "user/verify-otp"
        case resendOTP = "user/resend-otp"
        case profile = "user/profile"
        case category = "categories"
        case jobs = "jobs"
        case jobsEmployeer = "jobs/employeer"
        case jobsEmployer = "jobs/employer"
        case notification = "user/notification"
        case jobListing = "applications/jobListEmployee"
        case jobListEmployer = "applications/jobListEmployer"
        case applications = "applications" //for  apply job and save job
        case applicationsStatus = "applications/applicationStatus"
        case applicationsDetail = "applications/applicationDetail"
        case jobReport = "jobs/report"
        
        var path: String {
            return baseUrl + self.rawValue
        }
    }
    
}
