//
//  ListaRecordatoriosView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 03/02/23.
//

import SwiftUI

struct ListaRecordatoriosView: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    var recordatorios : [RecordatorioModel]
    @Binding var fechaAct : Date
    
    var body: some View {
        VStack(spacing: 20){
            Text("Recordatorios")
                .font(.title2.bold())
                .frame(maxWidth: .infinity,alignment: .leading)
                .foregroundColor(Color("primario"))
                .shadow(color: .white, radius: 3)
            
            //si encuentra alguna tarea en el dia seleccionado
            if loginShow.existeRecordatorio(dia: fechaAct, recordatorios: recordatorios){
                
                ForEach(loginShow.devuelveRecordatorio(dia: fechaAct, recordatorios: recordatorios)){ t in
                        VStack(alignment: .leading, spacing: 10){
                            Text(t.planta)
                                .font(.title2.bold())
                                .foregroundColor(.black)
                            Text(t.tipo)
                                .font(.title2)
                                .foregroundColor(.black)
                        }.padding(.vertical)
                            .frame( maxWidth: .infinity, alignment: .leading)
                            .background(Color("primario"))
                            .cornerRadius(10)
                    
                }
            }else{
                Text("No se encontraron").foregroundColor(.gray)
            }
        }
        .padding().onAppear{print("realizndo lista")}
    }
}
