//
//  DetallePlanta.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 09/01/23.
//

import SwiftUI

struct DetallePlanta: View {
    var foto : String
    var nombre : String
    
    var body: some View {
        VStack(alignment: .leading){
            NavBarDetallePlanta(foto: foto, nombre: nombre)
            //Spacer(minLength: 10)
            Text("Cereus Peruvianus Monstruoso")
                .padding(.leading)
                .font(.custom("Noteworthy", size: 20 ))
                .foregroundColor(.gray)
            Text("Proximo riego el 20/01/2023")
                .padding(.leading)
                .font(.custom("Noteworthy", size: 15 ))
                .foregroundColor(.gray)
            ScrollView (.horizontal){
                HStack(spacing: 15){
                    CardInfoView(seleccion: 0)
                    CardInfoView(seleccion: 1)
                    CardInfoView(seleccion: 2)
                    CardInfoView(seleccion: 3)
                    CardInfoView(seleccion: 4)
                }
                
            }.padding()
            Spacer()
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("")
    }
}
