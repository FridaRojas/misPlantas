//
//  EditaUsuario.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 25/01/23.
//

import SwiftUI

struct EditaUsuario: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    @Binding var modal : Bool
    @State var fotoNueva : Data = .init(capacity: 0)
    @State var nombreNuevo = ""
    @State var errorFirebase = false
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    
    var body: some View {
            NavigationStack{
                VStack{
                    Text("Edita tu perfil")
                        .padding(.horizontal)
                        .font(.custom("Noteworthy", size: 35))
                        .foregroundColor(Color.black)
                    //foto
                    VStack{
                        VStack{
                            Button(action:{
                                mostrarMenu.toggle()
                            }){
                                Text("Cambiar Imagen")
                                //Image(systemName: "plus.app").resizable().frame(width: 80, height: 80).foregroundColor(Color("primario"))
                            }.actionSheet(isPresented: $mostrarMenu) {
                                ActionSheet(title: Text("Seleccione"), buttons: [
                                    .default(Text("Camara"), action: {
                                        source = .camera
                                        imagePicker.toggle()
                                    }),
                                    .default(Text("Galeria"), action: {
                                        source = .photoLibrary
                                        imagePicker.toggle()
                                    }),
                                    .default(Text("Cancelar"))
                                ])
                            }
                            
                            if fotoNueva.count != 0 {
                                Image(uiImage: UIImage(data: fotoNueva)!)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(15)
                            }
                        }
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 4)
                    
                    //Nombre
                    VStack{
                        Text("Nombre: ").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                        TextField(loginShow.Usuario.nombre, text: $nombreNuevo).frame(width: 300, height: 40)
                            .background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                    }.padding(.horizontal).onAppear{ nombreNuevo = loginShow.Usuario.nombre}
                    
                    //Boton
                    Button(action:{
                        if fotoNueva.isEmpty{
                            loginShow.editarUsuario(nombreNuevo: nombreNuevo, fotoNuevo: nil){ done in
                                modal.toggle()
                                loginShow.obtieneUsuario(){ done in
                                } failure: { error in
                                    errorFirebase = true
                                }
                                loginShow.selectedTab = 4
                            } failure: { error in
                                errorFirebase = true
                            }
                        }else{
                            loginShow.editarUsuario(nombreNuevo: nombreNuevo, fotoNuevo: fotoNueva){ done in
                                modal.toggle()
                                loginShow.obtieneUsuario(){ done in
                                } failure: { error in
                                    errorFirebase = true
                                }
                                loginShow.selectedTab = 4
                            } failure: { error in
                                errorFirebase = true
                            }                        }
                    }){
                        Text("Guardar").foregroundColor(.white).bold()
                    }.padding()
                        .background(Color("primario"))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .alert(isPresented: $errorFirebase, content: {
                            Alert(title: Text("Error"),
                                  message: Text("Hubo un problema al modificar el usuario"),
                                  primaryButton: Alert.Button.destructive(Text("Cancelar"), action: {
                                modal.toggle()
                            }),
                                  secondaryButton: .default(Text("Reintentar")))
                        })
                    Spacer(minLength: 20)
                    
                }.padding().background(LinearGradient(gradient: Gradient(colors: [Color("primario"), .white]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea(.all)
                    .navigationDestination(isPresented: $imagePicker){
                    ImagePicker(show: $imagePicker, image: $fotoNueva, source: source)
                }
            }.ignoresSafeArea(.all)
    }
}

