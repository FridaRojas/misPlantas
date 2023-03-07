//
//  Login.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 16/01/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct Login: View {
    @State var errorFirebase = false
    @State private var email = ""
    @State private var pass = ""
    @State var modal = false
    @State var modalOlvide = false
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
                            loginShow.login(email: email, pass: pass){ resultado in
                                UserDefaults.standard.set(true, forKey: "sesion")
                                loginShow.show.toggle()
                                loginShow.obtieneUsuario(){ done in
                                } failure: { error in
                                    errorFirebase = true
                                }
                            } failure: { error in
                                errorFirebase = true
                            }
                        }){
                            Text("Entrar").font(.title)
                                .frame(width: 150, height: 50)
                                .foregroundColor(.white)
                                .background(email != "" && email != " " ? Color("primario") : Color.gray)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }.disabled(email != "" && email != " " ? false : true)
                            .alert(isPresented: $errorFirebase, content: {
                                Alert(title: Text("Eliminar"),
                                      message: Text("Hubo un problema al iniciar sesion, asegurese que su correo y contraseña sean correctos"),
                                      primaryButton: Alert.Button.destructive(Text("Cancelar"), action: {
                                    modal.toggle()
                                }),
                                      secondaryButton: .default(Text("Reintentar")))
                            })
                    }
                    VStack(alignment: .trailing){
                        Button(action:{
                            modalOlvide.toggle()
                        }){
                           Text("Olvide mi contraseña")
                        }.sheet(isPresented: $modalOlvide){
                            OlvideContrasena(modal: $modalOlvide)
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
                            loginShow.iniciaGoogle(presenting: getRootViewController()){ done in
                                print("se logueo por Google")
                                guard let id = Auth.auth().currentUser?.uid else {return}
                                loginShow.Usuario.id =  id
                                //existe el usuario?
                                loginShow.existeId(){ done in
                                    if done{
                                        //ya existe usuario
                                        UserDefaults.standard.set(true, forKey: "sesion")
                                    }else{
                                        //primera vez, crea usuario en db
                                        loginShow.obtieneDatosGoogle()
                                        loginShow.AgregarUsuario(nombre: loginShow.Usuario.nombre, correo: loginShow.Usuario.correo){ done in
                                            print("agrego usuario a firestore")
                                            loginShow.AgregarHabitacion(nombre: "Sala de estar", tipo: "Sala"){ done in
                                                print("agregue habitacion")
                                                UserDefaults.standard.set(true, forKey: "sesion")
                                            } failure: { error in
                                                errorFirebase = true
                                            }
                                            
                                        } failure: { error in
                                            errorFirebase = true
                                        }
                                    }
                                    
                                }failure: { error in
                                    errorFirebase = true
                                }
                                
                            } failure: { error in
                                errorFirebase = true
                            }
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
                    .onTapGesture {
                        self.hideKeyboard()
                    }
            }
        }.background(Image("hojitas").resizable())
            .edgesIgnoringSafeArea(.all)
    }
}

extension View{
    func getRootViewController() -> UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init()}
        guard let root = screen.windows.first?.rootViewController else { return . init()}
        
        return root
    }
}
