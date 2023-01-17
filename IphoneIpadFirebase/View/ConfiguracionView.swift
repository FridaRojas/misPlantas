//
//  ConfiguracionView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//

import SwiftUI
import FirebaseAuth

struct ConfiguracionView: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    var nombreUsuario = "Frida Rojas Alarcon"
    
    @State var recordatorios = true
    
    var body: some View {
        VStack{
            Spacer(minLength: 80)
            Image("perfil2")
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            Text(nombreUsuario)
                .font(.custom("Noteworthy", size: 40))
                .foregroundColor(Color.black)
            Button(action:{
                
            }){
                HStack(alignment: .center){
                    Text("Editar perfil")
                        .foregroundColor(.gray)
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.gray)
                }
            }
            Spacer(minLength: 10)
            ScrollView{
                VStack{
                    HStack{
                        Text("Notificaciones").padding().font(.custom("Noteworthy", size: 15)).foregroundColor(Color("primario"))
                        Spacer()
                    }
                    VStack{
                        HStack{
                            Image(systemName: "drop")
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("primario"))
                            Toggle("Recordatorios de Riego", isOn: $recordatorios).foregroundColor(.black)
                        }
                        HStack{
                            Image(systemName: "square.3.layers.3d.middle.filled")
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("primario"))
                            Toggle("Recordatorios de Abono", isOn: $recordatorios).foregroundColor(.black)
                        }
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 4)
                    HStack{
                        Text("Ayuda").padding().font(.custom("Noteworthy", size: 15)).foregroundColor(Color("primario"))
                        Spacer()
                    }
                    
                    VStack{
                        //List{
                        HStack{
                            Image(systemName: "bubble.left")
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("primario"))
                            Text("Enviar comentarios").foregroundColor(.black)
                            Spacer()
                        }.background(Color.white)
                        HStack{
                            Image(systemName: "questionmark.circle")
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("primario"))
                            Text("Preguntas frecuentes").foregroundColor(.black)
                            Spacer()
                        }.background(Color.white)
                        HStack{
                            Image(systemName: "exclamationmark.circle")
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("primario"))
                            Text("Sobre la aplicacion").foregroundColor(.black)
                            Spacer()
                        }.background(Color.white)
                        //}
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 4)
                    HStack{
                        Text("Cuenta").padding().font(.custom("Noteworthy", size: 15)).foregroundColor(Color("primario"))
                        Spacer()
                    }
                    
                    VStack{
                        //List{
                        Button(action:{
                            try! Auth.auth().signOut()
                            UserDefaults.standard.removeObject(forKey: "sesion")
                            loginShow.show = false
                        }){
                            HStack{
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("primario"))
                                Text("Cerrar sesion").foregroundColor(.black)
                                Spacer()
                            }.background(Color.white)
                        }
                        
                        HStack{
                            Image(systemName: "trash")
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("primario"))
                            Text("Eliminar cuenta").foregroundColor(.black)
                            Spacer()
                        }.background(Color.white)
                        HStack{
                            Image(systemName: "exclamationmark.circle")
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("primario"))
                            Text("Sobre la aplicacion").foregroundColor(.black)
                            Spacer()
                        }.background(Color.white)
                        //}
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 4)
                    Spacer(minLength: 100)
                }.padding()
            }.padding()
            
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
    }
}

