//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct CeldaPlantasView: View {
    var nombreHabitacion : String
    var imagen :String
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading){
                Spacer()
                HStack{
                    Spacer()
                    Image("cactus").resizable().frame(width: 50, height: 50).clipShape(Circle())
                    Image("cactus2").resizable().frame(width: 50, height: 50).clipShape(Circle())
                    Image("poto").resizable().frame(width: 50, height: 50).clipShape(Circle())
                }
                Text(nombreHabitacion).foregroundColor(.black)
            }
        }.padding(.all, 25)
            .frame(height: 120)
            .background(Color.white.opacity(0.9))
            .cornerRadius(8)
            .shadow(radius: 4)
        
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


