//
//  CeldaHabitaciones.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 06/01/23.
//

import SwiftUI

struct CeldaHabitaciones: View {
    
    var foto : String
    var nombre : String
    var fechaRiego : String
    var iluminacion : String
    
    var body: some View {
        HStack{
            Image(foto)
                .resizable()
                .frame(width: 50,height: 50)
                .clipShape(Circle())
            VStack{
                Text(nombre)
                    .font(.custom("Noteworthy", size: 20))
                    .bold()
                    .foregroundColor(.black)
                Text("Siguiente Riego: \(fechaRiego)")
                    .font(.custom("Noteworthy", size: 10))
                    .foregroundColor(.black)
            }
            Image(systemName: iluminacion == "sol" ? "sun.min.fill" : iluminacion == "sombra" ? "cloud.fill" : "cloud.sun.fill")
                .font(.title)
                .foregroundColor(Color("primario"))
        }.padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(8)
            .shadow(radius: 4)
    }
}

