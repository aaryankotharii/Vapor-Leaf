//
//  ContentView.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 10/11/20.
//

import SwiftUI

<<<<<<< HEAD
struct OnboardingView: View {
    var cupcakes : [Cupcake]
    //MARK - BODY
    var body: some View {
        TabView {
            ForEach(cupcakes) { cupcake in
                CupcakeCardView(cupcake: cupcake)
            } //: LOOP
        } //: TAB
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical,20)
    }
}

//MARK - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(cupcakes: [])
=======
struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
>>>>>>> 69e5749de1fc93628d7ed378f0a5254845fe048c
    }
}
