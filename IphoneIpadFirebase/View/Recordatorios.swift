//
//  RecordatoriosView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//
import SwiftUI

struct Recordatorios: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    @State var recordatorios = [RecordatorioModel]()
    @State var errorCarga = false
    @State var fecha : Date = Date()
    var body: some View {
        
        ZStack{
            
            VStack {
                
                if errorCarga {
                    VStack{
                        Spacer()
                        Text("Calendario no disponible en este momento").foregroundColor(.gray).font(.title)
                        Spacer()
                    }
                }else{
                    Spacer(minLength: 50)
                    ScrollView{
                        VStack{
                            CalendarioView(recordatorios: recordatorios, fechaAct: $fecha)
                        }.padding()
                    }
                }
                
            }.background(Image("fondo1").resizable())
                .edgesIgnoringSafeArea(.all)
                .onAppear{loginShow.obtieneRecordatorios(){ resultado in
                    recordatorios = resultado
                } failure: { error in
                    errorCarga = true
                    print("error...", error.localizedDescription)
                }}
            
            if recordatorios.isEmpty {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        VStack{
                            Image("carga")
                                .resizable().frame(width: 150, height: 150)
                            Text("Identificando tu plata...").background(Color.white)
                        }.padding().background(Color.white).cornerRadius(15)
                        Spacer()
                    }
                    Spacer()
                }.background(Color.white.opacity(0.9)).ignoresSafeArea(.all)
            }
        }
        
    }
}
