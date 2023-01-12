//
//  NavBarHabitaciones.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 06/01/23.
//

import SwiftUI

struct NavBarHabitaciones: View {
    var nombreHabitacion : String
    var numeroPlantas : String
    var imagenRecamara : String
    
    var body: some View {
        VStack( alignment: .leading){
            HStack {
                Text(nombreHabitacion)
                    .padding(.leading, 20)
                    .font(.custom("Noteworthy", size: 40))
                    .foregroundColor(Color.black).shadow(color: .white, radius: 5)
                
                Spacer()
            }
            HStack {
                Text("Aqui tienes \(numeroPlantas) plantas")
                    .padding(.leading, 35)
                    .font(.custom("Noteworthy", size: 15))
                    .foregroundColor(.black).shadow(color: .white, radius: 5)
            }
        }.padding(.bottom, 20).padding(.top, 150)
            .background(Image(imagenRecamara).resizable().frame(width: 400, height: 300).opacity(0.8))
            .cornerRadius(50)
            .shadow(radius: 10)
            .ignoresSafeArea(.all)
    }
}

