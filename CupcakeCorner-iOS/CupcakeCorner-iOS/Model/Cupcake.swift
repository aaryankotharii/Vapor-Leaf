//
//  Cupcake.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 10/11/20.
//

import Foundation
<<<<<<< HEAD
import Combine
import SwiftUI

struct Cupcake : Codable, Identifiable {
    let id : UUID?
    let name : String?
    let description : String?
    let price : Int?
    let image : String?
    let colors: String?
    
    func gradient() -> LinearGradient {
        let hexStrings = Array((colors ?? "").split(separator: ","))
        let colours = hexStrings.map{ Color(hexString: String($0)) }
        return LinearGradient(gradient: Gradient(colors:colours), startPoint: .top, endPoint: .bottom)
    }
}

let samplecupcake = Cupcake(id: UUID(), name: "Red Velvet", description: "very yummy", price: 6,image: "redvelvet", colors: ",")

let samplecupcakes = [samplecupcake,samplecupcake,samplecupcake]
  
=======
>>>>>>> 69e5749de1fc93628d7ed378f0a5254845fe048c
