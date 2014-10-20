let kgUnit = HKUnit(fromString: "kg")

let timsWeightKG = HKQuantity(unit: kgUnit, doubleValue: minionTim.weightInKG)

let ounceUnit = HKUnit.ounceUnit()

var timsWeightOunces: Double?
if timsWeightKG.isCompatibleWithUnit(ounceUnit) {
    timsWeightOunces = timsWeightKG.doubleValueForUnit(ounceUnit)
}

if let timsWeightOunces = timsWeightOunces {
    println("Tim's weight in ounces is \(timsWeightOunces)")
} else {
    println("Error: Tim's weight is not convertable to ounces!")
}

// Do the same as above for Stones! How many stones does Tim weight? What about your other minions? 











