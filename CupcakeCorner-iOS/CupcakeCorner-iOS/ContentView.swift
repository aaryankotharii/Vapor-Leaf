//
//  ContentView.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 11/11/20.
//

<<<<<<< HEAD
import SwiftUI

struct ContentView: View {
    //MARK - PROPERTIES
    var cupcakeAPI = CupcakeAPI()
    @State var cupcakes = [Cupcake]()
    var body: some View {
        Group{
            if cupcakes.count == 0{
                
            } else {
                OnboardingView(cupcakes: cupcakes)
            }
        }.onAppear{
            cupcakeAPI.fetchCupcakes {
                self.cupcakes = $0
            }
        }
    }
    
}
=======
import Foundation
>>>>>>> 69e5749de1fc93628d7ed378f0a5254845fe048c
