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
    @State var nuevaFecha = Date()
    @State var errorFirebase = false
    
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
                    HStack{
                        VStack(alignment: .leading, spacing: 10){
                            Text("\(t.tipo) de \(t.planta)!")
                                .padding(.horizontal)
                                .font(.custom("Noteworthy", size: 20))
                                .foregroundColor(.white)
                            Text("(Cada \(t.dias) \(t.periodo))")
                                .padding(.horizontal)
                                .font(.custom("Noteworthy", size: 15))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action:{
                            loginShow.actualizaRecordatorio(idHabitacion: t.idHabitacion, idPlanta: t.id, fechaNueva: RecordatorioViewModel.shared.sumaPeriodo(diaActual: fechaAct, numSuma: t.dias, periodo: t.periodo)){ done in
                                loginShow.selectedTab = 0
                            } failure: { error in
                                errorFirebase = true
                            }
                        }){
                            Text("Listo!").foregroundColor(.white).bold()
                        }.padding()
                            .background(Color("primario")).cornerRadius(10)
                            .alert(isPresented: $errorFirebase, content: {
                                Alert(title: Text("Error"),
                                      message: Text("Hubo un problema al modificar el recordatorio"),
                                      primaryButton: Alert.Button.destructive(Text("Cancelar"), action: {
                                    
                                }),
                                      secondaryButton: .default(Text("Reintentar")))
                            })
                    }.padding()
                        .frame( maxWidth: .infinity, alignment: .leading)
                        .background(Color.brown.opacity(0.5))
                        .cornerRadius(10)
                        
                    
                }
            }else{
                Text("No se encontraron").foregroundColor(.gray)
            }
        }
        .padding().onAppear{print("realizndo lista")}
    }
}
