//
//  Login.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 16/01/23.
//

import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var pass = ""
    @State var modal = false
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow : FirebaseViewModel
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        ZStack {
            VStack{
                VStack(spacing: 15){
                    Spacer(minLength: 20)
                    //saludo
                    VStack(alignment: .center){
                        Text("¡Hola de nuevo!")
                            .padding()
                            .font(.custom("Noteworthy", size: 40))
                            .foregroundColor(.black)
                        Text("Bienvenido de regreso, te extrañamos")
                            .padding()
                            .font(.custom("Noteworthy", size: 18))
                            .foregroundColor(.black)
                        
                    }
                    Spacer(minLength: 15)
                    //textFields
                    VStack(alignment: .center, spacing: 20){
                        TextField("Correo", text: $email )
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .frame(width: device == .pad ? 400 : nil, height: device == .pad ? 100 : 50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                        SecureField("Contraseña", text: $pass )
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .foregroundColor(.gray)
                            .frame(width: device == .pad ? 400 : nil, height: device == .pad ? 100 : 50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                        Button(action:{
                            login.login(email: email, pass: pass) { (done) in
                                if done{
                                    UserDefaults.standard.set(true, forKey: "sesion")
                                    loginShow.show.toggle()
                                }
                            }
                        }){
                            Text("Entrar").font(.title)
                                .frame(width: 150, height: 50)
                                .foregroundColor(.white)
                                .background(Color("primario"))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                    //o
                    HStack(alignment: .center){
                        Text("o continua con:")
                            .padding()
                            .font(.custom("Noteworthy", size: 15))
                            .foregroundColor(.black)
                    }.padding()
                    //botones facebook google
                    HStack(spacing: 25){
                        Button(action:{
                            
                        }){
                                Image("google")
                                    .resizable().frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                        }
                        Button(action:{
                            
                        }){
                                Image("facebook")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                        }
                    }
                    Spacer()
                    //no tienes cuenta?
                    HStack{
                        Text("No tienes cuenta?").foregroundColor(.black)
                        Button(action:{
                            modal.toggle()
                        }){
                         Text("Crea una")
                        }.sheet(isPresented: $modal){
                            CrearUsuarioView(modal: $modal)
                        }
                    }
                    Spacer()
                    
                }.padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(40)
                    .shadow(color: .white,radius: 10)
            }
        }.background(Image("hojitas").resizable())
            .edgesIgnoringSafeArea(.all)
    }
}
