//
//  DetallePlanta.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 09/01/23.
//

import SwiftUI

struct DetallePlanta: View {
    var planta : PlantasModel
    
    var body: some View {
        VStack(alignment: .leading){
            NavBarDetallePlanta(foto: planta.foto, nombre: planta.nombre)
            //Spacer(minLength: 10)
            Text("Cereus Peruvianus Monstruoso")
                .padding(.leading)
                .font(.custom("Noteworthy", size: 20 ))
                .foregroundColor(.gray)
            Text("Proximo riego: \(planta.proxRecordatorio)")
                .padding(.leading)
                .font(.custom("Noteworthy", size: 15 ))
                .foregroundColor(.gray)
            ScrollView (.horizontal){
                HStack(spacing: 15){
                    CardInfoView(planta: planta, seleccion: 0)
                    CardInfoView(planta: planta, seleccion: 1)
                    CardInfoView(planta: planta, seleccion: 2)
                    CardInfoView(planta: planta, seleccion: 3)
                    CardInfoView(planta: planta, seleccion: 4)
                }
                
            }.padding()
            Spacer()
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("")
    }
}
