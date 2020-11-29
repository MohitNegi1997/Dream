//
//  AppEnums.swift
//  Advisor
//
//  Created by Admin on 13/05/20.
//  Copyright © 2020 Sigma. All rights reserved.
//

import UIKit

enum DeviceType: String{
    case iPad = "2"
    case iPhone = "1"
    case none = "0"
}

enum TutorialData : CaseIterable{
    case slide1
    case slide2
    case slide3
   
    
    var title : String{
        switch self{
        case .slide1: return StringConstant.slide1Title.value
        case .slide2: return StringConstant.slide2Title.value
        case .slide3: return StringConstant.slide3Title.value
        
        }
    }
    
    var description : String{
        switch self {
        case .slide1: return StringConstant.slide1Description.value
        case .slide2: return StringConstant.slide2Description.value
        case .slide3: return StringConstant.slide3Description.value
       
        }
    }
    
    var image : UIImage? {
        switch self {
        case .slide1:return #imageLiteral(resourceName: "tutorialGraphic")
        case .slide2:return #imageLiteral(resourceName: "tutorialGraphic")
        case .slide3:return #imageLiteral(resourceName: "tutorialGraphic")
       
        }
    }
}

enum PickerType {
    case gender
    case education
    case language
    case jobPlace
    case currentLiving
    case workBefore
    case jobSector
    case monthlySalary
    case multiSelectionLanguage
    case unSkilledLabour
    case jobBenefits
    case educationForEmployer
    case skills
    
    var options : [String] {
        switch self {
        case .gender:
            return [StringConstant.male.value,StringConstant.female.value,StringConstant.other.value]
       
        case .education:
            return ["", StringConstant.lessThanClass10.value,StringConstant.class10Passed.value,StringConstant.diploma.value,StringConstant.graduateFillDegreeBelow.value]
       
        case .multiSelectionLanguage:
            return [ StringConstant.hindi.value,StringConstant.english.value,StringConstant.other.value]
       
        case .language:
            return [StringConstant.hindi.value,StringConstant.english.value,StringConstant.other.value]
      
        case .jobPlace:
            return [StringConstant.delhiNcr.value, StringConstant.outsideDelhiNcr.value]
      
        case .currentLiving:
            return [StringConstant.delhi.value,StringConstant.gurugram.value,StringConstant.ghaziabad.value,StringConstant.noida.value,StringConstant.faridabad.value,StringConstant.other.value]
       
        case .workBefore:
            return [StringConstant.hotelWaiterSecurityGuard.value,
                    StringConstant.constructionLabor.value,
                    StringConstant.paintingArtsCookingDriving.value,
                    StringConstant.factoryMachineOperator.value,
                    StringConstant.computerOperator.value,
                    StringConstant.retailShopkeeping.value,
                    StringConstant.noExperience.value,
                    StringConstant.other.value,
                  ]
        case .jobSector:
            return [StringConstant.unSkilledLabor.value,
                    StringConstant.unSkilledOther.value,
                    StringConstant.delivery.value,
                    StringConstant.skillCallCenter.value,
                    StringConstant.skilledMachineOperator.value,
                    StringConstant.deskofficejobs.value,
                    StringConstant.salesJob.value]
            
        case .monthlySalary:
            return [StringConstant.lessThanRs5000.value,
                    StringConstant.Rs5000Rs10000.value,
                    StringConstant.Rs10000Rs15000.value,
                    StringConstant.Rs15000Rs25000.value,
                    StringConstant.greaterThan25000.value]
            
        case .unSkilledLabour:
            return [StringConstant.constructionLabour.value,
                    StringConstant.factoryWork.value,
                    StringConstant.loadingAndUnloading.value,
                    StringConstant.packaging.value,
                    StringConstant.other.value]
            
        case .jobBenefits:
            return [StringConstant.none.value,
                    StringConstant.subsidizedFood.value,
                    StringConstant.accommodationForSelf.value,
                    StringConstant.accommodationForFamily.value,
                    StringConstant.insurance.value,
                    StringConstant.other.value]
            
        case .educationForEmployer:
            return [StringConstant.none.value,
                    StringConstant.tenthThPass.value,
                    StringConstant.twelveThPass.value,
                    StringConstant.iti.value,
                    StringConstant.diploma.value,
                    StringConstant.bachelorDegree.value,
                    StringConstant.masterDegree.value]
        case .skills:
            return [StringConstant.electrician.value,
                    StringConstant.plumbing.value,
                    StringConstant.wielding.value,
                    StringConstant.calling.value,
                    StringConstant.trainer.value]
        }
    }
}

enum ComingOnOTPFrom {
    case signup, forgotPassword, login
}

enum PopupList :CaseIterable {
    case saveJob
    case share
    case report
    
    var text :String {
        switch self {
        case .saveJob:
            return StringConstant.saveJob.value
        case .share:
            return StringConstant.share.value
        case .report:
            return StringConstant.report.value
            
        }
    }
    
    var image : UIImage? {
        switch self {
        case .saveJob:
            return #imageLiteral(resourceName: "bookmarkIcon")
        case .share:
            return #imageLiteral(resourceName: "shareIcon")
        case .report:
            return #imageLiteral(resourceName: "reportIcon")
            
        }
    }
}

enum EmployeeJobType {
    case saved, applied, shortlisted
}

enum JobDetailType {
    case edit,normal
}

var jobDetailType : JobDetailType = .normal
