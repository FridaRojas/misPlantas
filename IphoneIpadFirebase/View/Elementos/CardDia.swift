//
//  CeldaRecordatorio.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 03/02/23.
//

import SwiftUI

struct CardDia: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    var recordatorios : [RecordatorioModel]
    var value: FechaModel
    
    var body: some View {
        VStack{
            if value.dia != -1{
                if loginShow.existeRecordatorio(dia: value.fecha, recordatorios: recordatorios){
                    Text("\(value.dia)")
                        .font(.title3.bold())
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Circle()
                        .fill(Color("primario"))
                        .frame(width: 8, height: 8)
                }
                else{
                    Text("\(value.dia)")
                        .font(.title3.bold())
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                
            }
        }.padding(.vertical, 8)
            .frame(height: 60, alignment: .top)
    }
}
