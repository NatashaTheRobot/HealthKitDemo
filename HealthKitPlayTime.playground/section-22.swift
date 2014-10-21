// Let's localize Tim's weight to the US system

let massFormatter = NSMassFormatter()
massFormatter.forPersonMassUse = true

// Experiment: Change the Unit Style to Short or Medium
massFormatter.unitStyle = .Long

let timsLocalizedWeight = massFormatter.stringFromKilograms(minionTim.weightInKG)
// since we're in the U.S., Tim's weight is automatically converted to pounds!

"Minion Tim weights \(timsLocalizedWeight)"

// If needed, you can also just retrieve the localized unit enum and string value!
var massFormatterUnit = NSMassFormatterUnit.Kilogram
let timsLocalizedWeightUnit = massFormatter.unitStringFromKilograms(minionTim.weightInKG, usedUnit: &massFormatterUnit)
massFormatterUnit == NSMassFormatterUnit.Pound



// We can do the same thing to localize Tim's height to the U.S. measurement system

let lengthFormatter = NSLengthFormatter()
lengthFormatter.forPersonHeightUse = true
lengthFormatter.unitStyle = .Short


let timsHeightMeters = timsHeightCM.doubleValueForUnit(HKUnit.meterUnit())
let timsLocalizedHeight = lengthFormatter.stringFromMeters(timsHeightMeters)

var lengthFormatterUnit = NSLengthFormatterUnit.Meter
let timsLocalizedHeightUnit = lengthFormatter.unitStringFromMeters(timsHeightMeters, usedUnit: &lengthFormatterUnit)
lengthFormatterUnit == NSLengthFormatterUnit.Foot

"Minion Tim is \(timsLocalizedHeight) tall"


