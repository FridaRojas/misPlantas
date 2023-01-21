//
//  Habitacion.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 06/01/23.
//

import SwiftUI

struct Habitacion: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    var habitacion : HabitacionModel
    //var plantas : [PlantasModel]
    
    var body: some View {
        ZStack {
            
                VStack{
                    NavBarHabitaciones(nombreHabitacion: habitacion.nombre, numeroPlantas: String(loginShow.plantaActual.count), imagenRecamara: habitacion.tipo == "Recamara" ? "tipoRecamara" : habitacion.tipo == "Sala" ? "tipoSala" : habitacion.tipo == "Cocina" ? "tipoCocina" : habitacion.tipo == "Comedor" ? "tipoComedor" : habitacion.tipo == "Jardin" ? "tipoJardin" : "tipoBalcon")
                    Spacer()
                }
            if loginShow.plantaActual.count != 0 {
                    VStack{
                        Spacer(minLength: 250)
                        FiltroHabitaciones(plantas: loginShow.plantaActual)
                        
                    }
                }else {
                    VStack{
                        Text("No se encontraron plantas")
                    }
                }
            
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("").onAppear{
                print("entro a la habitacion")
                loginShow.obtienePlantas(idHabitacion: habitacion.id)
            }
    }
}


