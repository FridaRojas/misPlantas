//
//  CrearUsuarioView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 17/01/23.
//

import SwiftUI
import FirebaseAuth

struct CrearUsuarioView: View {
    
    @Binding var modal : Bool
    @State var correo : String = ""
    @State var contras : String = ""
    @State var nombre : String = ""
    @EnvironmentObject var loginShow : FirebaseViewModel
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        VStack{
            VStack{
                Spacer()
                VStack(alignment: .center){
                    Text("¡Crea tu usuario!")
                        .padding()
                        .font(.custom("Noteworthy", size: 40))
                        .foregroundColor(.black)
                    Text("Gracias por estar con nosotros")
                        .padding()
                        .font(.custom("Noteworthy", size: 18))
                        .foregroundColor(.black)
                    
                }
                Spacer()
                VStack(alignment: .center, spacing: 20){
                    TextField("Nombre", text: $nombre )
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .foregroundColor(.gray)
                        .frame(width: device == .pad ? 400 : nil, height: device == .pad ? 100 : 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(radius: 5)
                    TextField("Correo", text: $correo )
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .frame(width: device == .pad ? 400 : nil, height: device == .pad ? 100 : 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(radius: 5)
                    SecureField("Contraseña", text: $contras )
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .foregroundColor(.gray)
                        .frame(width: device == .pad ? 400 : nil, height: device == .pad ? 100 : 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .shadow(radius: 5)
                    
                    
                    Button(action:{
                        //inicia sesion
                        loginShow.crearUsuario(correo: correo, pass: contras) { (done) in
                            if done{
                                UserDefaults.standard.set(true, forKey: "sesion")
                                loginShow.show.toggle()
                                print("se logueo")
                                guard let id = Auth.auth().currentUser?.uid else {return}
                                loginShow.Usuario.id =  id
                                //crea usuario en db
                                loginShow.AgregarUsuario(nombre: nombre, correo: correo){ (done) in
                                    if done{
                                        correo = ""
                                        contras = ""
                                        nombre = ""
                                        print("agrego usuario a firebase")
                                        loginShow.obtieneUsuario()
                                        //crea su primera habitacion
                                        loginShow.AgregarHabitacion(nombre: "Sala de estar", tipo: "Sala"){ (done) in
                                            if done{
                                                print("agregue habitacion")
                                            }
                                            
                                        }
                                    }
                                }
                               
                            }
                        }
                        
                        
                        
                        modal.toggle()
                    }){
                        Text("Entrar").font(.title)
                            .frame(width: 150, height: 50)
                            .foregroundColor(.white)
                            .background(Color("primario"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
                Spacer()
            }.padding().background(Color.white.opacity(0.5))
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
    }
}
