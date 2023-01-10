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
                .font(.custom("Noteworthy", size: 20 ))
                .foregroundColor(.gray)
            Text("Originaria de América del Sur, bastante sencilla de cuidar pese a lo difícil que puede parecerlo debido a su extraña forma").foregroundColor(.gray).font(.title2)
            //Spacer(minLength: 5)
            ScrollView (.horizontal){
                HStack(spacing: 15){
                    CardInfoView(seleccion: 0)
                    CardInfoView(seleccion: 1)
                    CardInfoView(seleccion: 2)
                    CardInfoView(seleccion: 3)
                }
                
            }.padding()
            Spacer(minLength: 10)
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("")
    }
}
