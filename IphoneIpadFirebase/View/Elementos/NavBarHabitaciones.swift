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
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Text(nombreHabitacion)
                    .padding()
                    .font(.custom("Noteworthy", size: 30))
                    .foregroundColor(.black)
                
                Spacer()
            }
            HStack {
                Spacer()
                Text("Aqui tienes \(numeroPlantas) plantas")
                    .padding(.leading)
                    .font(.custom("Noteworthy", size: 15))
                    .foregroundColor(.black)
                
            }
            
        }.padding(.top, 60)
    }
}

