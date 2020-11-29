//
//  UserInputKeys.swift
//
//  Copyright © 2018 Advisor. All rights reserved.
//

import Foundation
// MARK: - Keys
enum Keys {
    static var accessToken: String { return "accessToken" }
    static var deviceId: String { return "deviceId" }
    static var password: String {return "password"}
    static var email: String {return "email"}
    static var firstLaunch: String {return "FirstLaunch"}
}

// MARK: - Api Keys
//=======================
enum ApiKey {
    
    // General Keys
    static var status: String { return "status" }
    static var response: String { return "response" }
    static var code: String { return "statusCode" }
    static var deviceId: String { return "deviceId" }
    static var deviceDetails: String { return "deviceDetails" }
    static var token: String { return "token" }
    static var authToken: String { return "authToken" }
    static var isPhoneVerified: String { return "isPhoneVerified" }
    static var isProfileCompleted: String { return "isProfileCompleted" }
    static var isNotificationEnabled: String { return "isNotificationEnabled" }
    static var result: String { return "RESULT" }
    static var data: String {return "data"}
    static var message: String { return "message" }
    static var Authorization: String { return "Authorization" }
    static var api_key: String { return "api_key" }
    static var contentType: String { return "Content-Type" }
    static var accept: String { return "Accept" }
    static var apiToken: String { return "api_token" }
    static var phoneKey: String { return "phone" }
    static var phoneNo: String { return "phoneNo" }
    static var flag: String { return "flag" }
    static var emoji: String { return "emoji" }
    static var user: String {return "user"}
    static var authorization: String {return "Authorization"}
    static var id: String {return "id"}
    static var type: String {return "type"}
    static var otp: String { return "otp" }
    static var lang: String { return "lang" }
    static var page: String { return "page" }
    static var limit: String { return "limit" }
    static var total: String { return "total" }
    static var next: String { return "next" }
    static var categoryId: String { return "categoryId" }
    static var search: String { return "search" }

    // Login keys
    static var email: String { return "email" }
    static var currentAddress : String { return "currentAddress"}
    static var industry : String { return "industry"}
    static var password: String { return "password" }
    static var confirmPassword: String { return "confirmPassword" }
    static var oldPassword: String { return "oldPassword" }
    static var name: String { return "name" }
    static var city : String { return "city" }
    static var currentPassword: String { return "currentPassword" }
    static var newPassword: String { return "newPassword" }
    static var userType: String { return "userType" }
    static var currentAddLocation: String { return "currentAddLocation" }
    static var currentLocation: String { return "currentLocation" }

    static var image: String { return "image" }
    static var pastWorks: String { return "pastWorks" }
    static var desiredSector: String { return "desiredSector" }
    static var writtenLanguage: String { return "writtenLanguage" }
    static var spokenLanguage: String { return "spokenLanguage" }
    static var gender: String { return "gender" }
    static var qualification: String { return "qualification" }
    static var age: String { return "age" }
    static var langMedium: String { return "langMedium" }
    static var countryCode: String { return "countryCode" }
    static var fromSalary: String { return "fromSalary" }
    static var toSalary: String { return "toSalary" }
    static var preferredJobLocation: String { return "preferredJobLocation" }
    static var coordinates: String { return "coordinates" }
    static var companyName: String { return "companyName" }
    static var companyContactNo: String { return "companyContactNo" }
    static var companyEmail: String { return "companyEmail" }
    static var contactName: String { return "contactName" }
    
    static var vacancies: String { return "vacancies" }
    static var requirement: String { return "requirement" }
    static var workingPerDay: String { return "workingPerDay" }
    static var workingPerWeek: String { return "workingPerWeek" }
    
    static var salary: String { return "salary" }
    static var benefits: String { return "benefits" }
    static var description: String { return "description" }
    static var ageRestriction: String { return "ageRestriction" }
    static var comments: String { return "comments" }
    static var isDelete: String { return "isDelete" }
    static var updatedAt: String { return "updatedAt" }
    static var createdAt: String { return "createdAt" }
    static var thumbURL: String { return "thumbURL" }
    
    static var jobType: String { return "jobType" }
    static var jobId: String { return "jobId" }
    static var workingType: String { return "workingType" }
    static var experience: String { return "experience" }
    static var reqSkills: String { return "reqSkills" }
    static var skills: String { return "skills" }
    
}

// MARK: - Api Code
//=======================
enum ApiCode {
    static var success: Int { return 200 } // Success
    static var created: Int { return 201 } // Created
    static var noContent: Int { return 204 } // no Content
    static var badRequest: Int { return 400 } // Bad Request
    static var unAuthorized: Int { return 440 } // session expire
    static var forbidden: Int { return 403 } // Forbidden
    static var notFound: Int { return 404 } // Not Found
    static var internalServerError: Int { return 500 } // Internal Server Error
    static var serviceUnavailable: Int { return 503 } // serviceUnavailable
}
