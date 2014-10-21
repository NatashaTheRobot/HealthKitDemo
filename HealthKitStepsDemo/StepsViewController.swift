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

    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
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
        
        activityIndicator.startAnimating()
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
                self.queryStepsSum()
                self.querySteps()
            } else {
                println(error.description)
            }
        })
    }
    
    func queryStepsSum() {
        let sumOption = HKStatisticsOptions.CumulativeSum
        let statisticsSumQuery = HKStatisticsQuery(quantityType: healthKitManager.stepsCount, quantitySamplePredicate: nil, options: sumOption) { [unowned self] (query, result, error) in
            if let sumQuantity = result?.sumQuantity() {
                let headerView = self.tableView.dequeueReusableCellWithIdentifier(self.totalStepsCellIdentifier) as UITableViewCell
                
                let numberOfSteps = Int(sumQuantity.doubleValueForUnit(self.healthKitManager.stepsUnit))
                headerView.textLabel.text = "\(numberOfSteps) total"
                self.tableView.tableHeaderView = headerView
            }
            self.activityIndicator.stopAnimating()
            
        }
        healthKitManager.healthStore?.executeQuery(statisticsSumQuery)
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
                self.activityIndicator.stopAnimating()
        }
        
        healthKitManager.healthStore?.executeQuery(sampleQuery)
    }
    
    
}