//
//  ComentariosView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 15/03/23.
//

import SwiftUI

struct ComentariosView: View {
    @Binding var modal : Bool
    
    var body: some View {
        VStack(alignment: .center){
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image(systemName: "bubble.left.circle.fill").font(.largeTitle).foregroundColor(Color("primario"))
                    Text("Envia tus comentarios")
                        .font(.custom("Noteworthy", size: 25))
                        .foregroundColor(Color("primario"))
                    Spacer()
                }.padding()
                Spacer()
                Text("¡Hola!, puedes enviar un correo a: ")
                    .font(.custom("Noteworthy", size: 20))
                    .foregroundColor(Color.black)
                Text("misPlantas@gmail.com")
                    .font(.custom("Noteworthy", size: 20))
                    .foregroundColor(Color.black).bold()
                Text("con el asunto:")
                    .font(.custom("Noteworthy", size: 20))
                    .foregroundColor(Color.black)
                Text("'comentario MisPlantas'")
                    .font(.custom("Noteworthy", size: 20))
                    .foregroundColor(Color.black)
                Text("Te agradecemos la ayuda!")
                    .padding(.vertical)
                    .font(.custom("Noteworthy", size: 20))
                    .foregroundColor(Color.black)
                Spacer()
            }//.background(Color.white.opacity(0.4))
            
        }.padding().background(Color.white)
            .ignoresSafeArea(.all)
        
    }
}

