//
//  SobreAplicacionView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 17/03/23.
//

import SwiftUI

struct SobreAplicacionView: View {
    @Binding var modal : Bool
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            HStack(alignment: .center){
               Image("Icon").resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
                VStack(alignment: .center){
                    Text("Sobre ")
                    Text("Mis Plantas")
                }.padding()
                    .font(.custom("Noteworthy", size: 25))
                    .font(.title).foregroundColor(Color("primario")).bold()
            }
            
            
            Spacer()
            Text("Está hecha pensando en personas que les gustan las plantas y quisieran estar mas organizadas o les cuesta trabajo acordarse cuando regaron todas sus plantas por ultima vez.")
                .font(.custom("Noteworthy", size: 15))
                .font(.title).foregroundColor(.gray).bold()
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "apple.logo")
                    Text("Versiones:")
                    Spacer()
                }
                Text("iOS: 16")
                Text("Xcode: 14.2")
                
            }.padding().font(.custom("Noteworthy", size: 15)).foregroundColor(.gray)
            
            Spacer()
        }.padding().background(Color.white)
    }
}
