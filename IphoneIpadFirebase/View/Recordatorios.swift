//
//  RecordatoriosView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//
import SwiftUI

struct Recordatorios: View {
    @State var fecha : Date = Date()
    var body: some View {
        
        VStack {
            Spacer(minLength: 50)
            ScrollView{
                VStack{
                    CalendarioView(fechaAct: $fecha)
                }.padding()
            }
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
    }
}
