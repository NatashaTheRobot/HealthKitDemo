//
//  UserDataTableViewController.swift
//  HealthKitUserData
//
//  Created by Natasha Murashev on 10/20/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import UIKit
import HealthKit

class UserDataTableViewController: UITableViewController {
    
    private let labelWithTextCellIdentifier = "LabelWithTextFieldTableViewCell"
    
    private let dataTypesToRead: NSSet = {
        let healthKitManager = HealthKitManager.sharedInstance
        return NSSet(objects:
            healthKitManager.dateOfBirthCharacteristic,
            healthKitManager.biologicalSexCharacteristic,
            healthKitManager.bloodTypeCharacteristic)
    }()
    
    private enum UserDataField: Int {
        case DateOfBirth, BiologicalSex, BloodType
        
        func data() -> (title: String, value: String?) {
            
            let healthKitManager = HealthKitManager.sharedInstance
            
            switch self {
            case .DateOfBirth:
                return ("Date of Birth:", healthKitManager.dateOfBirth)
            case .BiologicalSex:
                return ("Biological Sex:", healthKitManager.biologicalSex)
            case .BloodType:
                return ("Blood Type:", healthKitManager.bloodType)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HealthKitManager.sharedInstance.requestHealthKitAuthorization(dataTypesToWrite: nil, dataTypesToRead: dataTypesToRead)
    }


    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(labelWithTextCellIdentifier) as LabelWithTextFieldTableViewCell
        
        if let userDataField = UserDataField(rawValue: indexPath.row) {
            let data = userDataField.data()
            cell.configure(title: data.title, input: data.value)
        }
        
        return cell
    }

}
