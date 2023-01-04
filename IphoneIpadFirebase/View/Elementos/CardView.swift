//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack{
            VStack(spacing: 10){
                HStack{
                    Image("cactus")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(4)
                    Image("cactus2")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(4)
                }
                HStack{
                    Image("poto")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(4)
                    Image("hoja")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(4)
                }
                
            }.padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(8)
        
            Text("Recamara")
                .font(.custom("Noteworthy", size: 15))
                .foregroundColor(.black)
        }
    }
}


