//
//  OlvideContrasena.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 03/03/23.
//

import SwiftUI

struct OlvideContrasena: View {
    @Binding var modal : Bool
    @State var email = ""
    @State var errorFirebase = false
    @EnvironmentObject var loginShow : FirebaseViewModel
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        VStack{
            VStack{
                Spacer()
                Text("Olvide mi contraseña")
                    .padding()
                    .font(.custom("Noteworthy", size: 30))
                    .foregroundColor(.black)
                TextField("Correo", text: $email )
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .frame(width: device == .pad ? 400 : nil, height: device == .pad ? 100 : 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .shadow(radius: 5)
                Button(action:{
                    loginShow.restablecerContras(email: email){ done in
                        modal.toggle()
                    } failure: { error in
                        errorFirebase = true
                    }
                }){
                    Text("Enviar").foregroundColor(.white).bold()
                }.padding()
                    .background(Color("primario")).cornerRadius(10)
                    .alert(isPresented: $errorFirebase, content: {
                        Alert(title: Text("Error"),
                              message: Text("Hubo un problema al enviar el correo"),
                              primaryButton: Alert.Button.destructive(Text("Cancelar"), action: {
                            modal.toggle()
                        }),
                              secondaryButton: .default(Text("Reintentar")))
                    })
                Text("Enviaremos un correo para restablecer tu contraseña")
                    .padding()
                    .font(.custom("Noteworthy", size: 15))
                    .foregroundColor(.gray)
                Spacer()
            }.padding().background(Color.white.opacity(0.7))
        }.background(Image("hojitas").resizable())
            .edgesIgnoringSafeArea(.all).presentationDetents([.medium])
        
    }
}

