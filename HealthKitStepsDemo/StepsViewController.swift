//
//  StepsViewController.swift
//  HealthKitStepsDemo
//
//  Created by Natasha Murashev on 10/20/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import UIKit
import HealthKit

class StepsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak private var tableView: UITableView!
    
    private let stepCellIdentifier = "stepCell"
    private let totalStepsCellIdentifier = "totalStepsCell"
    
    private let healthKitManager = HealthKitManager.sharedInstance
    
    private var steps = [HKQuantitySample]()
    
    private let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        return formatter
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestHealthKitAuthorization()
    }

    // MARK: TableView Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(stepCellIdentifier) as UITableViewCell
        
        let step = steps[indexPath.row]
        let numberOfSteps = Int(step.quantity.doubleValueForUnit(healthKitManager.stepsUnit))
        
        cell.textLabel.text = "\(numberOfSteps) steps"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(step.startDate)
        
        return cell
    }
}

private extension StepsViewController {
    
    func requestHealthKitAuthorization() {
        let dataTypesToRead = NSSet(objects: healthKitManager.stepsCount)
        healthKitManager.healthStore?.requestAuthorizationToShareTypes(nil, readTypes: dataTypesToRead, completion: { [unowned self] (success, error) in
            if success {
                self.querySteps()
                self.queryStepsSum()
            } else {
                println(error.description)
            }
        })
    }
    
    func queryStepsSum() {
        let sumOptions = HKStatisticsOptions.CumulativeSum
        let statisticsQuery = HKStatisticsQuery(quantityType: healthKitManager.stepsCount, quantitySamplePredicate: nil, options: sumOptions) { [unowned self] (query, result, error) in
            if let sum = result?.sumQuantity() {
                let headerView = self.tableView.dequeueReusableCellWithIdentifier(self.totalStepsCellIdentifier) as UITableViewCell
                
                let numberOfSteps = Int(sum.doubleValueForUnit(self.healthKitManager.stepsUnit))
                headerView.textLabel.text = "\(numberOfSteps) total"
                self.tableView.tableHeaderView = headerView
                self.tableView.reloadData()
            }
            
        }
        healthKitManager.healthStore?.executeQuery(statisticsQuery)
    }
    
    func querySteps() {
        let sampleQuery = HKSampleQuery(sampleType: healthKitManager.stepsCount,
            predicate: nil,
            limit: 100,
            sortDescriptors: nil)
            { [unowned self] (query, results, error) in
                if let results = results as? [HKQuantitySample] {
                    self.steps = results
                    self.tableView.reloadData()
                }
        }
        
        healthKitManager.healthStore?.executeQuery(sampleQuery)
    }
    
    
}