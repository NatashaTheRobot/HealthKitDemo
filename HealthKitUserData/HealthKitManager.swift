//
//  HealthKitHelpers.swift
//  HealthKitUserData
//
//  Created by Natasha Murashev on 10/20/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import HealthKit

class HealthKitManager {
    
    class var sharedInstance: HealthKitManager {
        struct Singleton {
            static let instance = HealthKitManager()
        }
        
        return Singleton.instance
    }
    
    let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            return nil
        }
    }()
    
    let dateOfBirthCharacteristic = HKCharacteristicType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)
    
    let biologicalSexCharacteristic = HKCharacteristicType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex)
    
    let bloodTypeCharacteristic = HKCharacteristicType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBloodType)
    
     var dateOfBirth: String? {
        if let dateOfBirth = healthStore?.dateOfBirthWithError(nil) {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            return dateFormatter.stringFromDate(dateOfBirth)
        }
        return nil
    }
    
    var biologicalSex: String? {
        if let biologicalSex = healthStore?.biologicalSexWithError(nil) {
            switch biologicalSex.biologicalSex {
            case .Female:
                return "Female"
            case .Male:
                return "Male"
            case .NotSet:
                return nil
            }
        }
        return nil
    }
    
    var bloodType: String? {
        if let bloodType = healthStore?.bloodTypeWithError(nil) {
            
            switch bloodType.bloodType {
            case .APositive:
                return "A+"
            case .ANegative:
                return "A-"
            case .BPositive:
                return "B+"
            case .BNegative:
                return "B-"
            case .ABPositive:
                return "AB+"
            case .ABNegative:
                return "AB-"
            case .OPositive:
                return "O+"
            case .ONegative:
                return "O-"
            case .NotSet:
                return nil
            }
        }
        return nil
    }
    
    func requestHealthKitAuthorization(dataTypesToWrite: NSSet?, dataTypesToRead: NSSet?) {
            healthStore?.requestAuthorizationToShareTypes(dataTypesToWrite, readTypes: dataTypesToRead, completion: { (success, error) -> Void in
                if success {
                    println("success")
                } else {
                    println(error.description)
                }
            })
        }
}


