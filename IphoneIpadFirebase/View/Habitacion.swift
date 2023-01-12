//
//  Habitacion.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 06/01/23.
//

import SwiftUI

struct Habitacion: View {
    var nombreHabitacion : String
    var numeroPlantas : String
    var tipoHabitacion : String
    
    var body: some View {
        ZStack {
            VStack{
                NavBarHabitaciones(nombreHabitacion: nombreHabitacion, numeroPlantas: numeroPlantas, imagenRecamara: tipoHabitacion == "Recamara" ? "tipoRecamara" : tipoHabitacion == "Sala" ? "tipoSala" : tipoHabitacion == "Cocina" ? "tipoCocina" : tipoHabitacion == "Comedor" ? "tipoComedor" : tipoHabitacion == "Jardin" ? "tipoJardin" : "tipoBalcon")
                Spacer()
            }
            VStack (){
                Spacer(minLength: 250)
                HStack{
                    Spacer()
                    FiltroHabitaciones()
                }
            }
            
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("")
    }
}


