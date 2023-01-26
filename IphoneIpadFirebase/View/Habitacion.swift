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
        VStack {
            VStack{
                
                NavBarHabitaciones(habitacion: habitacion, numeroPlantas: String(loginShow.plantaActual.count))
                //Spacer()
            }
            VStack{
                if loginShow.plantaActual.count != 0 {
                    //Spacer(minLength: 250)
                    FiltroHabitaciones(plantas: loginShow.plantaActual, idHabitacion: habitacion)
                }else {
                    Spacer()
                    Text("No se encontraron plantas").foregroundColor(.gray)
                    Spacer(minLength: 150)
                }
            }
           
            Spacer(minLength: 50)
            
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("").onAppear{
                print("entro a la habitacion")
                loginShow.obtienePlantas(idHabitacion: habitacion.id)
            }
    }
}


