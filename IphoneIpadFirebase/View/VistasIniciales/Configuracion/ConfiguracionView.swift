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
    @State var modal = false
    @State var modalPreguntas = false
    @State var modalComentarios = false
    @State var modalSobreAplicacion = false
    @State var recordatorios = true
    
    var body: some View {
        VStack{
            Spacer(minLength: 80)
            ImagenFirebase(imagenUrl: loginShow.Usuario.foto)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            Text(loginShow.Usuario.nombre)
                .font(.custom("Noteworthy", size: 40))
                .foregroundColor(Color.black)
            Text(loginShow.Usuario.correo)
                .font(.custom("Noteworthy", size: 20))
                .foregroundColor(Color.black)
            Button(action:{
                modal.toggle()
            }){
                HStack(alignment: .center){
                    Text("Editar perfil")
                        .foregroundColor(.gray)
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.gray)
                }
            }.sheet(isPresented: $modal){
                EditaUsuario(modal: $modal).presentationDetents([.medium, .large])
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
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 4)
                    HStack{
                        Text("Ayuda").padding().font(.custom("Noteworthy", size: 15)).foregroundColor(Color("primario"))
                        Spacer()
                    }
                    
                    VStack{
                        Button(action:{
                            modalComentarios.toggle()
                        }){
                            HStack{
                                Image(systemName: "bubble.left")
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("primario"))
                                Text("Enviar comentarios").foregroundColor(.black)
                                Spacer()
                            }.background(Color.white)
                        }.sheet(isPresented: $modalComentarios){
                            ComentariosView(modal: $modalComentarios).presentationDetents([.medium])
                        }
                        
                        Button(action:{
                            modalPreguntas.toggle()
                        }){
                            HStack{
                                Image(systemName: "questionmark.circle")
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("primario"))
                                Text("Preguntas frecuentes").foregroundColor(.black)
                                Spacer()
                            }.background(Color.white)
                        }.sheet(isPresented: $modalPreguntas){
                            PreguntasView(modal: $modalPreguntas).presentationDetents([.large])
                        }
                        Button(action:{
                            modalSobreAplicacion.toggle()
                        }){
                            HStack{
                                Image(systemName: "exclamationmark.circle")
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("primario"))
                                Text("Sobre la aplicacion").foregroundColor(.black)
                                Spacer()
                            }.background(Color.white)
                        }.sheet(isPresented: $modalSobreAplicacion){
                            SobreAplicacionView(modal: $modalSobreAplicacion).presentationDetents([.medium])
                        }
                        
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

