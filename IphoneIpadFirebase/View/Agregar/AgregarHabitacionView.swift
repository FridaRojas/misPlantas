//
//  AgregarHabitacionView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 10/01/23.
//

import SwiftUI

struct AgregarHabitacionView: View {
    @Binding var modal : Bool
    @State var nombreHabitacion : String = ""
    @State var tipoHabitacionNombre : String = "Recamara"
    @State var tipoHabtacion = 0
    @State var progress = false
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        ZStack{
            VStack {
                Spacer(minLength: 100)
                Text("Datos de tu Habitacion:").font(.custom("Noteworthy", size: 40)).foregroundColor(.gray)
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    Spacer(minLength: 10)
                    VStack{
                        //nombre
                        VStack{
                            Text("Nombre:").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            TextField("", text: $nombreHabitacion).frame(width: 300, height: 40)
                                .background(Color.white).cornerRadius(10).foregroundColor(.black).shadow(radius: 2)
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        
                        Spacer(minLength: 20)
                        //tipo
                        VStack{
                            Text("¿De que tipo es?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                ScrollView(.horizontal){
                                    HStack{
                                        Button(action:{
                                            tipoHabitacionNombre = "Recamara"
                                            tipoHabtacion = 0
                                        }){
                                            VStack{
                                                Image(systemName: "lamp.floor.fill")
                                                    .frame(width: 80, height: 80)
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal)
                                                Text("Recamara")
                                                    .foregroundColor(.gray)
                                                
                                            }.frame(width: 100, height: 150)
                                                .background(tipoHabtacion == 0 ? Color("primario").opacity(0.4) : Color.gray.opacity(0.3))
                                                .cornerRadius(10)
                                        }
                                        
                                        Button(action:{
                                            tipoHabitacionNombre = "Sala"
                                            tipoHabtacion = 1
                                        }){
                                            VStack{
                                                Image(systemName: "chair.lounge.fill")
                                                    .frame(width: 80, height: 80)
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal)
                                                Text("Sala de estar")
                                                    .foregroundColor(.gray)
                                                
                                            }.frame(width: 100, height: 150)
                                                .background(tipoHabtacion == 1 ? Color("primario").opacity(0.4) : Color.gray.opacity(0.3))
                                                .cornerRadius(10)
                                        }
                                        
                                        Button(action:{
                                            tipoHabitacionNombre = "Comedor"
                                            tipoHabtacion = 2
                                        }){
                                            VStack{
                                                Image(systemName: "chair.fill")
                                                    .frame(width: 80, height: 80)
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal)
                                                Text("Comedor")
                                                    .foregroundColor(.gray)
                                                
                                            }.frame(width: 100, height: 150)
                                                .background(tipoHabtacion == 2 ? Color("primario").opacity(0.4) : Color.gray.opacity(0.3))
                                                .cornerRadius(10)
                                        }
                                        
                                        Button(action:{
                                            tipoHabitacionNombre = "Cocina"
                                            tipoHabtacion = 3
                                        }){
                                            VStack{
                                                Image(systemName: "refrigerator.fill")
                                                    .frame(width: 80, height: 80)
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal)
                                                Text("Cocina")
                                                    .foregroundColor(.gray)
                                                
                                            }.frame(width: 100, height: 150)
                                                .background(tipoHabtacion == 3 ? Color("primario").opacity(0.4) : Color.gray.opacity(0.3))
                                                .cornerRadius(10)
                                        }
                                        
                                        Button(action:{
                                            tipoHabitacionNombre = "Jardin"
                                            tipoHabtacion = 4
                                        }){
                                            VStack{
                                                Image(systemName: "tree")
                                                    .frame(width: 80, height: 80)
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal)
                                                Text("Jardin")
                                                    .foregroundColor(.gray)
                                                
                                            }.frame(width: 100, height: 150)
                                                .background(tipoHabtacion == 4 ? Color("primario").opacity(0.4) : Color.gray.opacity(0.3))
                                                .cornerRadius(10)
                                        }
                                        
                                        Button(action:{
                                            tipoHabitacionNombre = "Balcon"
                                            tipoHabtacion = 5
                                            
                                        }){
                                            VStack{
                                                Image(systemName: "door.french.open")
                                                    .frame(width: 80, height: 80)
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal)
                                                Text("Balcon")
                                                    .foregroundColor(.gray)
                                                
                                            }.frame(width: 100, height: 150)
                                                .background(tipoHabtacion == 5 ? Color("primario").opacity(0.4) : Color.gray.opacity(0.3))
                                                .cornerRadius(10)
                                        }
                                        
                                                                                
                                    }
                                    }
                                    
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        
                        Spacer(minLength: 20)
                        Button(action:{
                            progress.toggle()
                            loginShow.AgregarHabitacion(nombre: nombreHabitacion, tipo: tipoHabitacionNombre){ (done) in
                                if done{
                                    modal.toggle()
                                    
                                }
                                
                            }
                            
                        }){
                            Text("Crear").foregroundColor(.white).bold()
                        }.padding()
                            .background(nombreHabitacion != "" && nombreHabitacion != " " ?  Color("primario") : Color.gray)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .disabled(nombreHabitacion != "" && nombreHabitacion != " " ?  false : true )
                        
                        
                    }
                }.padding()
            }.background(Image("fondo1").resizable())
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    loginShow.obtieneHabitaciones()
                }
            if progress {
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Image("carga")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .background(Color.white)
                            .cornerRadius(15)
                        Spacer()
                }
                    Spacer()
                }.background(Color.white.opacity(0.3)).ignoresSafeArea(.all)
            }
            
        }
    }
}

