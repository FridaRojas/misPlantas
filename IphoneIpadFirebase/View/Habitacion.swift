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
    
    var body: some View {
        VStack{
            NavBarHabitaciones(nombreHabitacion: nombreHabitacion, numeroPlantas: numeroPlantas)
            FiltroHabitaciones()
            
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("")
    }
}


