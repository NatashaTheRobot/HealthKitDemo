import UIKit

class Minion {
    
    let name: String
    let favoriteActivity: String
    let heightInCM: Double
    let weightInKG: Double
    let image: UIImage?
    
    init(name: String, favoriteActivity: String, heightInCM: Double, weightInKG: Double) {
        self.name = name
        self.favoriteActivity = favoriteActivity
        self.heightInCM = heightInCM
        self.weightInKG = weightInKG
        self.image = UIImage(named: "Minion\(name)")
    }
}

let minionTim = Minion(name: "Tim", favoriteActivity: "Soccer", heightInCM: 120, weightInKG: 10)

