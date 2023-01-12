//
//  FiltroHabitaciones.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 06/01/23.
//

import SwiftUI

struct FiltroHabitaciones: View {
    @State var seleccionIlumina = 0
    
    
    var body: some View {
        VStack(alignment: .center){
            //Spacer()
            
            HStack {
                BotonSeleccion(seleccionIlumina: self.$seleccionIlumina)
                //Spacer()
            }
            
            if self.seleccionIlumina == 0{
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    VStack(spacing: 15){
                        NavigationLink(destination: DetallePlanta(foto: "cactusmounstro", nombre: "Cactus Mounstro")){
                            CeldaHabitaciones(foto: "cactusmounstro", nombre: "Cactus Mounstro", fechaRiego: "10/01/2023", iluminacion: "sol")
                        }
                        CeldaHabitaciones(foto: "cactusmounstro", nombre: "Cactus Mounstro", fechaRiego: "10/01/2023", iluminacion: "sol")
                        CeldaHabitaciones(foto: "Cactussorgano", nombre: "Cactus Organo", fechaRiego: "10/01/2023", iluminacion: "sol")
                        CeldaHabitaciones(foto: "manitososo", nombre: "Manitas de Oso", fechaRiego: "10/01/2023", iluminacion: "sol")
                        CeldaHabitaciones(foto: "monstera", nombre: "Monstera Deliciosa", fechaRiego: "10/01/2023", iluminacion: "sombra")
                        CeldaHabitaciones(foto: "helecho", nombre: "Helecho", fechaRiego: "10/01/2023", iluminacion: "sombra")
                        CeldaHabitaciones(foto: "croton", nombre: "Croton", fechaRiego: "10/01/2023", iluminacion: "ambos")
                        CeldaHabitaciones(foto: "potos", nombre: "Potos", fechaRiego: "10/01/2023", iluminacion: "ambos")
                    }.padding()
                    
                }
            }
            else if self.seleccionIlumina == 1{
                //plantas de sol
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    CeldaHabitaciones(foto: "cactusmounstro", nombre: "Cactus Mounstro", fechaRiego: "10/01/2023", iluminacion: "sol")
                    CeldaHabitaciones(foto: "Cactussorgano", nombre: "Cactus Organo", fechaRiego: "10/01/2023", iluminacion: "sol")
                    CeldaHabitaciones(foto: "manitososo", nombre: "Manitas de Oso", fechaRiego: "10/01/2023", iluminacion: "sol")
                }
            }
            else if self.seleccionIlumina == 2{
                //plantas de sombra
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    CeldaHabitaciones(foto: "monstera", nombre: "Monstera Deliciosa", fechaRiego: "10/01/2023", iluminacion: "sombra")
                    CeldaHabitaciones(foto: "helecho", nombre: "Helecho", fechaRiego: "10/01/2023", iluminacion: "sombra")
                }
                
            }
            else{
                //ambas
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    CeldaHabitaciones(foto: "croton", nombre: "Croton", fechaRiego: "10/01/2023", iluminacion: "ambos")
                    CeldaHabitaciones(foto: "potos", nombre: "Potos", fechaRiego: "10/01/2023", iluminacion: "ambos")
                }
                
            }
            Spacer()
            
        }.edgesIgnoringSafeArea(.all)
        
        
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


