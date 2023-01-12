//
//  AgregarView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//

import SwiftUI

struct AgregarPlantaView: View {
    
    @State var nombrePlanta : String = ""
    @State var riego : String = ""
    @State private var iluminacion = true
    @State private var seleccionRiego: String = "Dias"
    @State private var seleccionAbono: String = "Semanas"
    @State var abono : String = ""
    let items = ["Dias", "Semanas", "Meses"]
    
    var body: some View {
        
        VStack {
            Spacer(minLength: 50)
            Text("Datos de tu planta:").font(.custom("Noteworthy", size: 40)).foregroundColor(.gray)
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                //Spacer(minLength: 20)
                VStack(alignment: .leading){
                    VStack{
                        VStack{
                            Text("Añade fotos").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            HStack{
                                Spacer()
                                Image(systemName: "plus.app").resizable().frame(width: 80, height: 80).foregroundColor(Color("primario"))
                                Image(systemName: "plus.app").resizable().frame(width: 80, height: 80).foregroundColor(Color("primario"))
                                Image(systemName: "plus.app").resizable().frame(width: 80, height: 80).foregroundColor(Color("primario"))
                                Spacer()
                            }
                        }.padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 4)
                        
                        Spacer(minLength: 20)
                        
                        VStack{
                            Text("Nombre o apodo:").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            TextField("", text: $nombrePlanta).frame(width: 300, height: 40)
                                .background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        Spacer(minLength: 20)
                        
                        VStack{
                            Text("¿Cada cuanto se debe regar?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            HStack{
                                Spacer()
                                TextField("", text: $riego).frame(width: 50, height: 40).background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                                Picker("Select one option", selection: $seleccionRiego) {
                                    ForEach(items, id: \.self) {
                                        Text("\($0)")
                                            .foregroundColor(Color("primario"))
                                    }
                                }
                                Spacer()
                            }
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        
                        Spacer(minLength: 20)
                    }
                    VStack{
                        VStack{
                            Spacer()
                            Toggle("Es de sol?", isOn: $iluminacion).frame(width: 300).font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            Spacer()
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        Spacer(minLength: 20)
                        VStack{
                            Text("¿Cada cuanto necesita Abono?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            HStack{
                                Spacer()
                                TextField("", text: $abono).frame(width: 50, height: 40).background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                                Picker("Select one option", selection: $seleccionAbono) {
                                    ForEach(items, id: \.self) {
                                        Text("\($0)")
                                            .foregroundColor(Color("primario"))
                                    }
                                }
                                Spacer()
                            }
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        
                        Spacer(minLength: 20)
                        Button(action:{
                            
                        }){
                            Text("Guardar").foregroundColor(.white).bold()
                        }.padding()
                            .background(Color("primario"))
                            .cornerRadius(8)
                            .shadow(radius: 4)
                        Spacer(minLength: 100)
                    }
                    
                }.padding()
            }.padding()
        }.background(Image("fondo1").resizable())
            .edgesIgnoringSafeArea(.all)
    }
}

