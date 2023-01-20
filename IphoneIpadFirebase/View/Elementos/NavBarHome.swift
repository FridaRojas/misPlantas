//
//  SaludoNavBar.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//

import SwiftUI

struct NavBarHome: View {
    var nombre : String
    var numHabitaciones : Int
    
    var body: some View {
        VStack{
            HStack {
                Text("¡Hola \(nombre)!")
                    .padding()
                    .font(.custom("Noteworthy", size: 40))
                    .foregroundColor(.black)
                
                Spacer()
                Button(action:{
                    
                }){
                 Image(systemName: "bell.fill")
                        .padding()
                        .font(.title)
                        .foregroundColor(Color("primario"))
                        
                        //.shadow(radius: 4)
                }
            }
            HStack {
                Text("Actualmente tienes \(numHabitaciones) habitaciones")
                    .padding(.leading)
                    .font(.custom("Noteworthy", size: 15))
                    .foregroundColor(.black)
                
                Spacer()
            }
            
        }.padding(.top, 50)
    }
}

