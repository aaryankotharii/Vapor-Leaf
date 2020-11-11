//
//  ContentView.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 10/11/20.
//

import SwiftUI

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
    }
}
