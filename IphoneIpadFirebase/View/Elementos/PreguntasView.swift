//
//  PreguntasView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 15/03/23.
//

import SwiftUI

struct PreguntasView: View {
    @Binding var modal : Bool
    var body: some View {
        VStack{
            VStack(alignment: .center){
                Text("PREGUNTAS FRECUENTES").font(.title).foregroundColor(Color("primario")).bold()
                Spacer()
            }
            VStack(alignment: .leading){
                Text("Pregunta1........?").font(.title3).foregroundColor(Color("primario")).bold()
                Text("Respuesta super extra mega largaaaaaaaaaaaaaaaa").foregroundColor(Color("primario"))
            }
            VStack(alignment: .leading){
                Text("Pregunta1........?").font(.title3).foregroundColor(Color("primario")).bold()
                Text("Respuesta super extra mega largaaaaaaaaaaaaaaaa").foregroundColor(Color("primario"))
            }
            VStack(alignment: .leading){
                Text("Pregunta1........?").font(.title3).foregroundColor(Color("primario")).bold()
                Text("Respuesta super extra mega largaaaaaaaaaaaaaaaa").foregroundColor(Color("primario"))
            }
            VStack(alignment: .leading){
                Text("Pregunta1........?").font(.title3).foregroundColor(Color("primario")).bold()
                Text("Respuesta super extra mega largaaaaaaaaaaaaaaaa").foregroundColor(Color("primario"))
            }
            Spacer()
        }.padding()
            .background(Color.white).ignoresSafeArea(.all)
    }
}

