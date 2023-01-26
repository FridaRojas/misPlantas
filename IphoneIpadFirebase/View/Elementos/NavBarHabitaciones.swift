//
//  NavBarHabitaciones.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 06/01/23.
//

import SwiftUI

struct NavBarHabitaciones: View {
    var habitacion : HabitacionModel
    var numeroPlantas : String
    @State var modal = false
    @State var alerta = false
    @State var atras = false
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        VStack( alignment: .leading){
            HStack(spacing: 10){
                Spacer()
                Button(action:{
                    alerta = true
                }){
                    Image(systemName: "trash.fill").padding()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                        .background(Color.white)
                        .cornerRadius(15)
                }.alert(isPresented: $alerta, content: {
                    Alert(title: Text("Eliminar"),
                          message: Text("¿Estas seguro de eiminar la habitacion \(habitacion.nombre) junto con sus plantas?"),
                          primaryButton: Alert.Button.destructive(Text("Aceptar"), action: {
                        loginShow.eliminarHabitacion(item: habitacion)
                        atras = true
                    }),
                          secondaryButton: .default(Text("Cancelar")))
                })
                
                NavigationLink(destination: Home(), isActive: $atras, label: {EmptyView()})
                
                Button(action:{
                    modal.toggle()
                }){
                    Image(systemName: "square.and.pencil")//.foregroundColor(Color("primario"))
                }.padding()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.orange)
                    .background(Color.white)
                    .cornerRadius(15)
                    .sheet(isPresented: $modal){
                        EditaHabitacion(habitacion: habitacion, modal: $modal).presentationDetents([.medium])
                    }
            }.padding()
            HStack {
                Text(habitacion.nombre)
                    .padding(.leading, 20)
                    .font(.custom("Noteworthy", size: 40))
                    .foregroundColor(Color.black).shadow(color: .white, radius: 5)
                
                Spacer()
            }
            HStack {
                Text("Aqui tienes \(numeroPlantas) plantas")
                    .padding(.leading, 35)
                    .font(.custom("Noteworthy", size: 15))
                    .foregroundColor(.black).shadow(color: .white, radius: 5)
            }
        }.padding(.top, 80)
            .background(Image("tipo\(habitacion.tipo)").resizable().frame(width: 400, height: 300).opacity(0.8))
            .cornerRadius(50)
            .shadow(radius: 10)
            .ignoresSafeArea(.all)
    }
}

