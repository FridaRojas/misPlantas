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
                    if recordatorios.count != 0 {
                        Spacer(minLength: 50)
                        ScrollView{
                            VStack{
                                CalendarioView(recordatorios: recordatorios, fechaAct: $fecha)
                            }.padding()
                        }
                    }else{
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                Text("Aun no cuentas con recordatorios").foregroundColor(.gray)
                                Spacer(minLength: 150)
                            }
                            Spacer()
                        }
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
                if recordatorios.count != 0{
                    GifView()
                }
            }
        }
        
    }
}
