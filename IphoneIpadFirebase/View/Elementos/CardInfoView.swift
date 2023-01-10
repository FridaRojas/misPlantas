//
//  CardInfoView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 09/01/23.
//

import SwiftUI

struct CardInfoView: View {
    var seleccion : Int
    var body: some View {
            VStack(spacing: 10){
                HStack{
                    Image(systemName: seleccion == 0 ? "drop" : seleccion == 1 ? "sun.min" : seleccion == 2 ? "square.3.layers.3d.middle.filled" :  "note.text")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(seleccion == 0 ? Color.blue.opacity(0.5) : seleccion == 1 ? Color.red.opacity(0.5) : seleccion == 2 ? Color.purple.opacity(0.5) :  Color.orange.opacity(0.5))
                    Spacer()
                }
                HStack{
                    Text(seleccion == 0 ? "Agua" : seleccion == 1 ? "Sol" : seleccion == 2 ? "Abono" :  "Notas")
                        .foregroundColor(seleccion == 0 ? Color.blue.opacity(0.5) : seleccion == 1 ? Color.red.opacity(0.5) : seleccion == 2 ? Color.purple.opacity(0.5) :  Color.orange.opacity(0.5))
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                HStack{
                    Text(seleccion == 0 ? "lalala" : seleccion == 1 ? "descripcion" : seleccion == 2 ? "detallaada" :  "lalala")
                        .foregroundColor(seleccion == 0 ? Color.blue.opacity(0.5) : seleccion == 1 ? Color.red.opacity(0.5) : seleccion == 2 ? Color.purple.opacity(0.5) :  Color.orange.opacity(0.5))
                        .font(.title2)
                    Spacer()
                }
                
            }.padding()
                .background(seleccion == 0 ? Color.blue.opacity(0.3) : seleccion == 1 ? Color.red.opacity(0.3) : seleccion == 2 ? Color.purple.opacity(0.3) :  Color.orange.opacity(0.3))
                .cornerRadius(8)
                .shadow(radius: 8)
    }
}

