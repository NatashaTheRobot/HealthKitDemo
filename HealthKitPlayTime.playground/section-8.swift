
// First, we need to create a HealthKit centimeter unit
// Note that to make life easier, you can specify a HealthKit Unit from a string
let centimeterUnit = HKUnit(fromString: "cm")

// Next, we need to create a HealthKit quantity (Tim's heigh is 120cm)
let timsHeightCM = HKQuantity(unit: centimeterUnit, doubleValue: minionTim.heightInCM)

// We can also create an inches unit
// Notice that HealthKit has built-in Units
let inchUnit = HKUnit.inchUnit()

// For example, you also instantiate the centimeter unit like this:
let cmUnit = HKUnit.meterUnitWithMetricPrefix(.Centi)

