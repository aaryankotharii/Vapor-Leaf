//
//  OrderButtonView.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 11/11/20.
//

import SwiftUI

struct OrderButtonView: View {
    //MARK - PROPERTIES
    var cupcake : Cupcake
    @State var showTextfield : Bool = false
    @State var buyerName : String
    //MARK - BODY
    var body: some View {
        VStack{
            Group {
                Button(action: startClicked, label: {
                    HStack(spacing: 8){
                        Text("Order Now")
                        Image(systemName: "arrow.right.circle")
                            .imageScale(.large)
                            .rotationEffect(showTextfield ? .degrees(90) : .zero )
                            .animation(.easeInOut)
                    }
                    .padding(.horizontal, 16.0)
                    .padding(.vertical, 10.0)
                    .foregroundColor(.white)
                    .background(Capsule().strokeBorder(Color.white, lineWidth: 1.25))
                    
                }) //: BUTTON
                if showTextfield{
                    HStack(spacing: -50) {
                        TextField("Enter buyer Name", text: $buyerName)
                            .frame(width: 200,alignment: .center)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: order, label: {
                            Text("Order")
                                .clipShape(Capsule())
                        })
                    }
                }
            }
        }
    }
    
    func startClicked(){
        self.showTextfield.toggle()
    }
    
    func order(){
        let order = Order(cakeName: cupcake.name ?? "", buyerName: buyerName)
        CupcakeAPI().orderCupcake(order: order) {
            print($0)
        }
    }
}

//MARK - PREVIEW
struct OrderButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OrderButtonView(cupcake: samplecupcake, buyerName: "")
            .previewLayout(.sizeThatFits)
    }
}

