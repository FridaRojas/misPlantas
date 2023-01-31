//
//  FiltroHabitaciones.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 06/01/23.
//

import SwiftUI

struct FiltroHabitaciones: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    @State var seleccionIlumina = 0
    var plantas : [PlantasModel]
    
    
    var body: some View {
        VStack(alignment: .center){
            HStack {
                BotonSeleccion(seleccionIlumina: self.$seleccionIlumina)
            }.padding(.horizontal)
            
            if self.seleccionIlumina == 0{
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    VStack(spacing: 15){
                        ForEach (loginShow.plantasActuales){item in
                            Button(action:{
                                loginShow.mandaItemPlanta(planta: item)
                            }){
                                CeldaHabitaciones(foto: item.foto, nombre: item.nombre, fechaRiego: item.proxRecordatorio, iluminacion: item.iluminacion)
                            }.navigationDestination(isPresented: $loginShow.NavegacionPlanta){
                                DetallePlanta()
                            }
                        }
                    }.padding()
                }
            }
            else if self.seleccionIlumina == 1{
                //plantas de sol
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    VStack(spacing: 15){
                        ForEach (loginShow.plantasActuales){item in
                            VStack{
                                if item.iluminacion == "Sol"{
                                    Button(action:{
                                        //navegacion = true
                                        loginShow.mandaItemPlanta(planta: item)
                                    }){
                                        CeldaHabitaciones(foto: item.foto, nombre: item.nombre, fechaRiego: item.proxRecordatorio, iluminacion: item.iluminacion)
                                    }.navigationDestination(isPresented: $loginShow.NavegacionPlanta){
                                        DetallePlanta()
                                    }
                                }
                            }
                            
                        }
                    }.padding()
                }
            }
            else if self.seleccionIlumina == 2{
                //plantas de sombra
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    VStack(spacing: 15){
                        ForEach (loginShow.plantasActuales){item in
                            VStack{
                                if item.iluminacion == "Sombra"{
                                    Button(action:{
                                        //navegacion = true
                                        loginShow.mandaItemPlanta(planta: item)
                                    }){
                                        CeldaHabitaciones(foto: item.foto, nombre: item.nombre, fechaRiego: item.proxRecordatorio, iluminacion: item.iluminacion)
                                    }.navigationDestination(isPresented: $loginShow.NavegacionPlanta){
                                        DetallePlanta()
                                    }
                                }
                            }
                            
                        }
                    }.padding()
                }
                
            }
            else{
                //ambas
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    VStack(spacing: 15){
                        ForEach (loginShow.plantasActuales){item in
                            VStack{
                                if item.iluminacion == "Ambos"{
                                    Button(action:{
                                        //navegacion = true
                                        loginShow.mandaItemPlanta(planta: item)
                                    }){
                                        CeldaHabitaciones(foto: item.foto, nombre: item.nombre, fechaRiego: item.proxRecordatorio, iluminacion: item.iluminacion)
                                    }.navigationDestination(isPresented: $loginShow.NavegacionPlanta){
                                        DetallePlanta()
                                    }
                                }
                            }
                            
                        }
                    }.padding()
                }
                
            }
            Spacer()
            
        }.edgesIgnoringSafeArea(.all).onAppear{
            print("entro a filtro")
            //loginShow.obtienePlantas(idHabitacion: loginShow.habitacionActual.id)
            print("num en filtro: \(loginShow.plantasActuales.count)")
        }
        
        
    }
}

struct BotonSeleccion : View {
    
    @Binding var seleccionIlumina : Int
    
    var body : some View{
        
        VStack{
            
            //Spacer(minLength: 0)
            
            HStack{
                Button(action: {
                    self.seleccionIlumina = 0
                }) {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(self.seleccionIlumina == 0 ? Color("primario") : .gray)
                        .padding(5)
                        .background(self.seleccionIlumina == 0 ? Color.gray.opacity(0.5) : Color.gray.opacity(0.3))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(self.seleccionIlumina == 0 ? Color.gray.opacity(0.5) : Color.gray.opacity(0.3)))
                        
                }
                
                //Spacer(minLength: 5)
                
                Button(action: {
                    self.seleccionIlumina = 1
                }) {
                    Image(systemName: "sun.min.fill")
                        .foregroundColor(self.seleccionIlumina == 1 ? Color("primario") : .gray)
                        .padding(5)
                        .background(self.seleccionIlumina == 1 ? Color.gray.opacity(0.5) : Color.gray.opacity(0.3))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(self.seleccionIlumina == 1 ? Color.gray.opacity(0.5) : Color.gray.opacity(0.3)))
                        
                }
                
                //Spacer(minLength: 5)
                
                Button(action: {
                    self.seleccionIlumina = 2
                }) {
                    Image(systemName: "cloud.fill")
                        .foregroundColor(self.seleccionIlumina == 2 ? Color("primario") : .gray)
                        .padding(5)
                        .background(self.seleccionIlumina == 2 ? Color.gray.opacity(0.5) : Color.gray.opacity(0.3))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(self.seleccionIlumina == 2 ? Color.gray.opacity(0.5) : Color.gray.opacity(0.3)))
                }
                
                //Spacer(minLength: 5)
                
                Button(action: {
                    self.seleccionIlumina = 3
                }) {
                    Image(systemName: "cloud.sun.fill")
                        .foregroundColor(self.seleccionIlumina == 3 ? Color("primario") : .gray)
                        .padding(5)
                        .background(self.seleccionIlumina == 3 ? Color.gray.opacity(0.5) : Color.gray.opacity(0.3))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(self.seleccionIlumina == 3 ? Color.gray.opacity(0.5) : Color.gray.opacity(0.3)))
                }
                
                
                
            }.padding()
                .background(Color("primario"))
                .clipShape(Capsule()).padding(22)
                .shadow(radius: 5)
        }.edgesIgnoringSafeArea(.bottom)
    }
}


