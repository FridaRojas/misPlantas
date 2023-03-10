//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct ListaHabitacionesView: View {
    var body: some View {
        var nombreHabitacion : String
        
        HStack{
            VStack{
                Spacer()
                Text(nombreHabitacion).foregroundColor(.white).bold()
            }
            Spacer()
        }.padding()
            .frame(width: .infinity, height: 45)
            .background(Image(""))
            .cornerRadius(8)
            .shadow(radius: 5)
        
        /*
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
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .shadow(radius: 4)
        
            Text("Recamara")
                .font(.custom("Noteworthy", size: 15))
                .foregroundColor(.black)
        }*/
    }
}


