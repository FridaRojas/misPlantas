//
//  EleccionAgregaview.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 22/02/23.
//

import SwiftUI

struct EleccionAgregaview: View {
    @Binding var modal : Bool
    @State var modalPlanta = false
    @State var modalHabitacion = false
    var body: some View {
        VStack(spacing: 50){
            Spacer()
            HStack{
                Spacer(minLength: 5)
                Text("¿Que necesitas agregar?").font(.custom("Noteworthy", size: 30)).foregroundColor(.gray)
                Spacer(minLength: 5)
            }
            
            Button(action:{
                modalPlanta.toggle()
            }){
                HStack{
                    Spacer()
                    Text("Planta")
                    Spacer()
                    Image(systemName: "leaf")
                    Spacer()
                }.font(.title)
                    .frame(width: 250, height: 50)
                    .foregroundColor(.white)
                    .background(Color("primario"))
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }.sheet(isPresented: $modalPlanta){
                    AgregarPlantaView(modal: $modalPlanta).presentationDetents([.large])
                    //EditaUsuario(modal: $modal).presentationDetents([.medium, .large])
                }
            
            Button(action:{
                modalHabitacion.toggle()
            }){
                HStack{
                    Spacer()
                    Text("Habitacion")
                    Spacer()
                    Image(systemName: "lamp.table")
                    Spacer()
                }.font(.title)
                    .frame(width: 250, height: 50)
                    .foregroundColor(.white)
                    .background(Color("primario"))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
            }.sheet(isPresented: $modalHabitacion){
                    AgregarHabitacionView(modal: $modalHabitacion).presentationDetents([.large])
                    //EditaUsuario(modal: $modal).presentationDetents([.medium, .large])
                }
            
            Spacer()
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
    }
}
