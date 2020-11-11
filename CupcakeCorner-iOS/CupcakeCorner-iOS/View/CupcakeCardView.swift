//
//  CupcakeCardView.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 10/11/20.
//

import SwiftUI

struct CupcakeCardView: View {
    //MARK - PROPERTIES
    var cupcake : Cupcake
    @State private var isAnimating : Bool = false
    
    //MARK - Body
    var body: some View {
        ZStack{
            VStack(spacing: 10) {
                // FRUIT: IMAGE
                RemoteImage(url: cupcake.image ?? "")
                    .scaledToFit()
                    .shadow(color: Color.black.opacity(0.16), radius: 8, x: 6, y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                    .padding(60)
                
                HStack{
                   // Spacer()
                    Text("$\(cupcake.price ?? 0)")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 60))
                        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 2, y: 2)
                    
                        // FRUIT : TITlE
                        Text(cupcake.name ?? "")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 2, y: 2)
                   // Spacer()
                }
                // BUTTON : ORDER
                OrderButtonView(cupcake: cupcake, buyerName: "")
                    .padding(.top, 50)
                
            } //: VSTACK
        } //: ZSTACK
        .onAppear(perform: animateView)
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(cupcake.gradient())
        .cornerRadius(20)
        .padding(.horizontal,20)
    }
    
    func animateView(){
        withAnimation(.easeOut(duration: 0.5)) {
            isAnimating = true
        }
    }
}

//MARK - Preview
struct CupcakeCardView_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeCardView(cupcake: samplecupcake)
    }
}
