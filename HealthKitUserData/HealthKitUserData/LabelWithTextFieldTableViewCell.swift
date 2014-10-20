//
//  LabelWithTextFieldTableViewCell.swift
//  HealthKitUserData
//
//  Created by Natasha Murashev on 10/20/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import UIKit

class LabelWithTextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var textField: UITextField!

    func configure(#title: String, input: String?) {
        label.text = title
        textField.text = input
    }

}
