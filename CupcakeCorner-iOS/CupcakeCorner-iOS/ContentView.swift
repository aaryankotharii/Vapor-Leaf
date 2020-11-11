//
//  ContentView.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 11/11/20.
//

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
