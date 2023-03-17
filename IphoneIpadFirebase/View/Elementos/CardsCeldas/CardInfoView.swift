//
//  CardInfoView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 09/01/23.
//

import SwiftUI
//------------------- cambiar : Recibir icono, titulo y texto 
struct CardInfoView: View {
    var planta : PlantasModel
    var seleccion : Int
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Image(systemName: seleccion == 0 ? "drop" :
                        seleccion == 1 ? "sun.min" :
                        seleccion == 2 ? "square.3.layers.3d.middle.filled" :
                        seleccion == 3 ? "note.text" : "questionmark.diamond")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(seleccion == 0 ? Color.blue.opacity(0.5) : seleccion == 1 ? Color.red.opacity(0.5) : seleccion == 2 ? Color.purple.opacity(0.5) : seleccion == 3 ? Color.orange.opacity(0.5) : Color.green.opacity(0.5))
                Spacer()
            }
            HStack{
                Text(seleccion == 0 ? "Riego" :
                        seleccion == 1 ? "Iluminacion" :
                        seleccion == 2 ? "Abono" :
                        seleccion == 3 ? "Notas" : "Detalles")
                    .foregroundColor(seleccion == 0 ? Color.blue.opacity(0.5) : seleccion == 1 ? Color.red.opacity(0.5) : seleccion == 2 ? Color.purple.opacity(0.5) : seleccion == 3 ? Color.orange.opacity(0.5) : Color.green.opacity(0.5))
                    .font(.title2)
                    .bold()
                Spacer()
            }
            HStack{
                Text(seleccion == 0 ? "cada \(planta.riegoNum) \(planta.riegoPeriod)" :
                        seleccion == 1 ? planta.iluminacion :
                        seleccion == 2 ? "cada \(planta.abonoNum) \(planta.abonoPeriod)" :
                        seleccion == 3 ? "lalala" : "Cereus Peruvianus Monstruoso")
                    .foregroundColor(seleccion == 0 ? Color.blue.opacity(0.5) : seleccion == 1 ? Color.red.opacity(0.5) : seleccion == 2 ? Color.purple.opacity(0.5) : seleccion == 3 ? Color.orange.opacity(0.5) : Color.green.opacity(0.5))
                    .font(.title2)
                Spacer()
            }
            
            
        }.padding()
            .frame(width: 180, height: 250)
            .background(seleccion == 0 ? Color.blue.opacity(0.1) : seleccion == 1 ? Color.red.opacity(0.1) : seleccion == 2 ? Color.purple.opacity(0.1) : seleccion == 3 ? Color.orange.opacity(0.1) : Color.green.opacity(0.1))
            .cornerRadius(8)
            .shadow(radius: 4)
    }
}

