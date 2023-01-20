//
//  AgregarHabitacionView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 10/01/23.
//

import SwiftUI

struct AgregarHabitacionView: View {
    @State var nombreHabitacion : String = ""
    @State var tipoHabitacionNombre : String = ""
    @State var tipoHabtacion = 0
    @StateObject var db = FirebaseViewModel()
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
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
                        db.AgregarHabitacion(nombre: nombreHabitacion, tipo: tipoHabitacionNombre, idUsuario: "8IerCiimAID44GdvYP4v"){ (done) in
                            if done{
                                nombreHabitacion = ""
                                tipoHabitacionNombre = ""
                                tipoHabtacion = 0
                            }
                            
                        }
                        
                    }){
                        Text("Crear").foregroundColor(.white).bold()
                    }.padding()
                        .background(Color("primario"))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                    
                    
                }
            }.padding()
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
    }
}

