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
    var fechaRiego : Date
    var iluminacion : String
    
    var body: some View {
        HStack{
            ImagenFirebase(imagenUrl: foto)
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
            VStack(alignment: .leading){
                Text(nombre)
                    .font(.custom("Noteworthy", size: 20))
                    .bold()
                    .foregroundColor(.black)
                Text("Siguiente Riego: \(fechaRiego)")
                    .font(.custom("Noteworthy", size: 10))
                    .foregroundColor(.black)
            }
            Spacer()
            Image(systemName: iluminacion == "Sol" ? "sun.min.fill" : iluminacion == "Sombra" ? "cloud.fill" : "cloud.sun.fill")
                .font(.title)
                .foregroundColor(Color("primario"))
        }.padding(.all, 25)
            .frame(height: 100)
            .background(Color.white.opacity(0.9))
            .cornerRadius(8)
            .shadow(radius: 4)
    }
}

