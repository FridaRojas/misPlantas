//
//  Habitacion.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 06/01/23.
//

import SwiftUI

struct Habitacion: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    @State var errorFirebase = false
    
    var body: some View {
        ZStack{
            
            VStack {
                NavBarHabitaciones(habitacion: loginShow.habitacionActual)
                
                    if loginShow.plantasActuales.count != 0 {
                        FiltroHabitaciones(plantas: loginShow.plantasActuales)
                    }else {
                        VStack{
                            Spacer()
                            Text("No se encontraron plantas").foregroundColor(.gray)
                            Spacer(minLength: 150)
                        }
                    }
                
                Spacer(minLength: 50)
                
            }.background(Image("fondo1").resizable())
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("")
                
            
            //cargando...
            if loginShow.plantasActuales.isEmpty {
                if loginShow.plantasActuales.count != 0  {
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            Image("carga")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .background(Color.white)
                                .cornerRadius(15)
                            Spacer()
                            
                        }
                        Spacer()
                    }.background(Color.white.opacity(0.5)).ignoresSafeArea(.all)
                }
            }
            
        }.onAppear{
            loginShow.obtienePlantas(idHabitacion: loginShow.habitacionActual.id){ done in
            } failure: { error in
                errorFirebase = true
            }
            print("numero de plantas en habitacion \(loginShow.plantasActuales.count)")
        }
    }
}


