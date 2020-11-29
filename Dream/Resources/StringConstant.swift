//
//  StringConstant.swift
//  Advisor
//
//  Created by Admin on 15/04/20.
//  Copyright © 2020 AssetLock. All rights reserved.
//

import Foundation

enum StringConstant: String {
    
    // MARK: - Default Values
    //==================================
    case emptyString = ""
    case settings = "settings"
    case cancel = "cancel"
    case ok = "ok"
    
    // MARK: - UIViewController Extension
    //=================================
    case chooseOptions = "ChooseOptions"
    case camera = "Camera"
    case cameraNotAvailable = "CameraNotAvailable"
    case chooseImage = "ChooseImage"
    case chooseFromGallery = "ChooseFromGallery"
    case takePhoto = "TakePhoto"
    case alert = "Alert"
    case restrictedFromUsingCamera = "RestrictedFromUsingCamera"
    case changePrivacySettingAndAllowAccessToCamera = "ChangePrivacySettingAndAllowAccessToCamera"
    case restrictedFromUsingLibrary = "RestrictedFromUsingLibrary"
    case changePrivacySettingAndAllowAccessToLibrary = "ChangePrivacySettingAndAllowAccessToLibrary"
    case removePhoto = "removePhoto"
    case openCameraGallery = "openCameraGallery"
    
    // MARK: - Validation Messages
    //==================================
    case pleaseEnterValidEmail = "pleaseEnterValidEmail"
    case pleaseEnterCurrentPassword = "pleaseEnterCurrentPassword"
    case pleaseEnterValidPassword = "pleaseEnterValidPassword"
    case nameShouldBeAtleastMinCharacters = "nameShouldBeAtleastMinCharacters"
    case pleaseEnterFirstName = "pleaseEnterFirstName"
    case pleaseEnterLastName = "pleaseEnterLastName"
    case pleaseEnterDOB = "pleaseEnterDOB"
    case pleaseEnterSpouseFirstName = "pleaseEnterSpouseFirstName"
    case pleaseEnterSpouseLastName = "pleaseEnterSpouseLastName"
    case pleaseEnterSpouseDOB = "pleaseEnterSpouseDOB"
    case pleaseEnterEmail = "pleaseEnterEmail"
    case pleaseEnterPassword = "pleaseEnterPassword"
    case pleaseEnterPhoneNumber = "pleaseEnterPhoneNumber"
    case pleaseEnterAddress = "pleaseEnterAddress"
    case pleaseEnterCity = "pleaseEnterCity"
    case pleaseEnterState = "pleaseEnterState"
    case pleaseEnterZip = "pleaseEnterZip"
    case pleaseEnterName = "pleaseEnterName"
    case pleaseEnterCompanyName = "pleaseEnterCompanyName"
    case pleaseEnterIndustryName = "pleaseEnterIndustryName"
    case pleaseFillAllTheFields = "pleaseFillAllTheFields"
    case pleaseEnterNewPassword = "pleaseEnterNewPassword"
    case pleaseEnterOldPassword = "pleaseEnterOldPassword"
    case pleaseEnterConfirmNewPassword = "pleaseEnterConfirmNewPassword"
    case passwordsDoNotMatch = "passwordsDoNotMatch"
    case pleaseEnterTitle = "pleaseEnterTitle"
    case pleaseEnterDescription = "pleaseEnterDescription"
    case pleaseEnterURL = "pleaseEnterURL"
    case pleaseEnterVimeoId = "pleaseEnterVimeoId"
    case pleaseEnterValidURL = "pleaseEnterValidURL"
    case pleaseEnterExtension = "pleaseEnterExtension"
    case pleaseEnterOTP = "pleaseEnterOTP"
    case pleaseSelectGender = "pleaseSelectGender"
    case pleaseSelectEducationalQualification = "pleaseSelectEducationalQualification"
    case pleaseSelectCurrentAddress = "pleaseSelectCurrentAddress"
    case areYouSureYouWantToLogout

    // MARK: - Prelogin Values
    //==================================
    case signin = "signin"
    case email = "email"
    case password = "password"
    case forgotPassword = "forgotPassword"
    case name = "name"
    case phoneNumber = "phoneNumber"
    case answer = "answer"
    case search = "search"
    case enterProductName = "Enter Product Name"
    case question = "question"
    case yourQuestion = "yourQuestion"
    case signInWithFaceID = "signInWithFaceID"
    case signInWithFingerPrint = "signInWithFingerPrint"
    case invalidBiometrics = "invalidBiometrics"
    case lockedOutBiometric = "lockedOutBiometric"
    case loginError = "loginError"
    case biometricAuthNotAvailable = "biometricAuthNotAvailable"
    case overrideBioMetricMessage = "overrideBioMetricMessage"
    case error = "error"
    case biometric = "biometric"
    case newPassword = "newPassword"
    case confirmNewPassword = "confirmNewPassword"
    case currentPassword = "currentPassword"
    case confirmPassword
    case contactNumber
    case emailId
    case forgot
    case forgotPassWordDesc
    case send
    case gender
    case age
    case educationalQualification
    case schoolCollegeLanguageMedium
    case create
    case profile
    case completeProfileDes
    case male
    case female
    case other
    case whichPlaceAreYoulookingForaJob
    case whichPlaceAreYoulivingIn 
    case currentAddress
    case address
    case location
    case applicants
    case industry
    case companyName
    case permanentAddress
    case previous
    case lessThanClass10
    case class10Passed
    case diploma
    case graduateFillDegreeBelow
    case whereYouHaveWorkedBefore
    case languageSpoken
    case languageWriting
    case salaryRange
    case monthlySalary
    case whichListedJobYouPrefer
    case sectorYouWantToApplyFor
    case delhi
    case gurugram
    case ghaziabad
    case noida
    case faridabad
    case hotelWaiterSecurityGuard
    case constructionLabor
    case paintingArtsCookingDriving
    case factoryMachineOperator
    case computerOperator
    case retailShopkeeping
    case noExperience
    case ekatra
    case viewJobs
    case profileSuccessfulllyCreated
    case views
    case posted

    case unSkilledLabor
    case unSkilledLaborRequiredFor
    case unSkilledOther
    case delivery
    case skillCallCenter
    case skilledMachineOperator
    case deskofficejobs
    case salesJob
    case otpScreenDesc
    case submit
    case didnotReceiveCode
    case requestNew
    case otp
    case verification
    case bookMarks
    case setting
    case workedBeforeAs
    case schoolCollegeMedium
    case wantToApplyFor
    case save
    case changeLanguage
    case userGuide
    case myProfile
    case editProfile
    case saveJob
    case share
    case report
    case notification
    case workDescription
    case noOfVacancy
    case needFor
    case nameOfcontactPerson
    case genderPreferences
    case ageRestrictions
    case additionalComments
    case descreption
    case postAJob
    case qualification
    case qualificationRequired
    case educationalQualificationRequired
    case uploadImage
    case nameOfCompany
    case mentionIndustry 
    case companyDetails
    case salaryPerMonth
    case jobBenefits
    case shortlistCandidate
    case accounts
    case payments
    case postedJobs
    case delhiNcr
    case outsideDelhiNcr
    case lessThanRs5000
    case Rs5000Rs10000
    case Rs10000Rs15000
    case Rs15000Rs25000
    case greaterThan25000
    case getStarted
    case successfullyApplied
    case applyForMoreJobs
    case applyNow
    case backToHome
    case skilled
    case unSkilled
    case labour

    case constructionLabour
    case factoryWork
    case loadingAndUnloading
    case packaging
    case none
    case subsidizedFood
    case accommodationForSelf
    case accommodationForFamily
    case insurance
    case tenthThPass
    case twelveThPass
    case iti
    case bachelorDegree
    case masterDegree
    case images
    case totalExperienceInYears
    case electrician
    case plumbing
    case wielding
    case calling
    case trainer
    case skills
    case requiredSkills
    case requiredExperienceInYears
    
    
    // MARK: - Job Detail
    //==================================
    case jobSuccessfullyPosted
    case jobSuccessfullyEdited
    case jobDetail
    case callingHandeling
    case partTime
    case onlyMale
    case jobDescreption
    case salary
    case vacancy
    case workingHours
    case workingDaysPerWeek
    case workingHrsPerDay
    case contactPerson
    case pending
    case shortlisted
    case rejected
    case applied
    case apply
    case applicantDetail
    case skilledLabour
    case unskilledLabour
    case clearAll
    case applyFilter
    case sent
    case message
    //MARK:- Setting VC
    //=========================
    case changePassword
    case notificationPreference
    case help
    case privacyPolicy
    case termsConditions
    case contactUs
    case logOut
    
    // MARK: - Popup Messages
    //==================================
    case forgotPasswordEmailSuccess = "forgotPasswordEmailSuccess"
    case changePasswordSuccess = "changePasswordSuccess"
    
    // MARK: - Login Option Messages
    //==================================
    case getJob = "getJob"
    case hireStaff = "hireStaff"
    
    // MARK: - Choose Language Screen
    //==================================
    case english = "english"
    case hindi = "hindi"
    case selectLanguage = "selectLanguage"
    
    // MARK: - LogIn  Screen
    //==================================
    case login = "login"
    case sigma = "sigma"
    case signup = "signup"
    case dontHaveAnAccount = "dontHaveAnAccount"
    case register = "register"
    case registerTo = "registerTo"
    case next = "next"
    case haveAnAccount = "haveAnAccount"
    case loginTo
    case createNew
    case createNewPass = "createNewPass"
    case confirmNewPass = "confirmNewPass"
    case companyProfile = "companyProfile"
    case createCompanyProfileDesc = "createCompanyProfileDesc"
    
    // MARK:- Tutorials
    //==========================
    case slide1Title
    case slide2Title
    case slide3Title
    case slide1Description
    case slide2Description
    case slide3Description
    
    // MARK:- TabBar
    //==========================
    case home
    case categories
    case myJobs
    
    // MARK:- Job Post
    //==========================
    case pleaseEnterVacansies
    case pleaseEnterRequirement
    case pleaseEnterContactName
    case pleaseEnterWorkingHour
    case pleaseEnterWorkingDay
    case pleaseEnterSalary
    case pleaseEnterBenefits
    case pleaseEnterQualification
    case pleaseEnterGender
    case pleaseEnterAgeRestriction
    case pleaseEnterRequiredSkills
    case pleaseEnterExperience
    case pleaseEnterComments
    case pleaseEnterWorkingType
    case pleaseEnterCategory
    case pleaseEnterImage
    
    
    // MARK: - Logout Values
    //==================================
    case sessionExpired = "sessionExpired"
}

extension StringConstant {
    var value: String {
        return self.rawValue.localized 
    }
}

extension String {
    
    ///Returns a localized string
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
