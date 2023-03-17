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
                Text("PREGUNTAS FRECUENTES").padding()
                    .font(.custom("Noteworthy", size: 20))
                    .font(.title).foregroundColor(Color.black).bold()
            }
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        //Image(systemName: "circle.fill")
                        Text("¿Cómo identificar una planta?")
                            .padding(.horizontal)
                            .font(.custom("Noteworthy", size: 18))
                            .foregroundColor(Color("primario")).bold()
                        Spacer()
                    }
                    Text("Al tomar la fotografia, asegurate que tenga una luz adecuada y salga unicamente la especie a identificar, puedes tomar fotografia de la hoja, rama o planta completa")
                        .padding(.horizontal)
                        .font(.custom("Noteworthy", size: 15))
                        .foregroundColor(Color.gray)
                }.padding(.vertical)//.background(Color.white.opacity(0.6)).cornerRadius(10)
                VStack(alignment: .leading){
                    HStack{
                        Text("¿Cómo identificar una planta?")
                            .padding(.horizontal)
                            .font(.custom("Noteworthy", size: 18))
                            .foregroundColor(Color("primario")).bold()
                        Spacer()
                    }
                    Text("Al tomar la fotografia, asegurate que tenga una luz adecuada y salga unicamente la especie a identificar, puedes tomar fotografia de la hoja, rama o planta completa")
                        .padding(.horizontal)
                        .font(.custom("Noteworthy", size: 15))
                        .foregroundColor(Color.gray)
                }.padding(.vertical)//.background(Color.white.opacity(0.6)).cornerRadius(10)
                VStack(alignment: .leading){
                    HStack{
                        Text("¿Cómo identificar una planta?")
                            .padding(.horizontal)
                            .font(.custom("Noteworthy", size: 18))
                            .foregroundColor(Color("primario")).bold()
                        Spacer()
                    }
                    Text("Al tomar la fotografia, asegurate que tenga una luz adecuada y salga unicamente la especie a identificar, puedes tomar fotografia de la hoja, rama o planta completa")
                        .padding(.horizontal)
                        .font(.custom("Noteworthy", size: 15))
                        .foregroundColor(Color.gray)
                }.padding(.vertical)//.background(Color.white.opacity(0.6)).cornerRadius(10)
                VStack(alignment: .leading){
                    HStack{
                        Text("¿Cómo identificar una planta?")
                            .padding(.horizontal)
                            .font(.custom("Noteworthy", size: 18))
                            .foregroundColor(Color("primario")).bold()
                        Spacer()
                    }
                    Text("Al tomar la fotografia, asegurate que tenga una luz adecuada y salga unicamente la especie a identificar, puedes tomar fotografia de la hoja, rama o planta completa")
                        .padding(.horizontal)
                        .font(.custom("Noteworthy", size: 15))
                        .foregroundColor(Color.gray)
                }.padding(.vertical)//.background(Color.white.opacity(0.6)).cornerRadius(10)
                Spacer()
            }
            
        }.padding()
            .background(Color.white).ignoresSafeArea(.all)
    }
}

