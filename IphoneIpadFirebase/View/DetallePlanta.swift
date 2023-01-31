//
//  DetallePlanta.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 09/01/23.
//

import SwiftUI

struct DetallePlanta: View {
    //var planta : PlantasModel
    //var idHabitacion : HabitacionModel
    
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .leading){
                NavBarDetallePlanta(planta: loginShow.plantaActual, idHabitacion: loginShow.habitacionActual)
                Text("Proximo riego: \(loginShow.plantaActual.proxRecordatorio)")
                    .padding(.leading)
                    .font(.custom("Noteworthy", size: 15 ))
                    .foregroundColor(.gray)
                ScrollView (.horizontal){
                    HStack(spacing: 15){
                        CardInfoView(planta: loginShow.plantaActual, seleccion: 0)
                        CardInfoView(planta: loginShow.plantaActual, seleccion: 1)
                        CardInfoView(planta: loginShow.plantaActual, seleccion: 2)
                        CardInfoView(planta: loginShow.plantaActual, seleccion: 3)
                        CardInfoView(planta: loginShow.plantaActual, seleccion: 4)
                    }
                    
                }.padding()
                Spacer(minLength: 120)
            }.background(Image("fondo1").resizable())
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("")
            
            if loginShow.plantaActual.foto.isEmpty {
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
    }
}
