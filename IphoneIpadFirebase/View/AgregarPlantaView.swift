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
    @State private var seleccionIluminacion = "Sol"
    @State private var seleccionRiego: String = "Dias"
    @State private var seleccionAbono: String = "Semanas"
    @State private var seleccionHabitacion: String = "Recamara"
    @State var abono : String = ""
    let itemIluminacion = ["Sol", "Sombra", "Ambos"]
    let itemRiego = ["Dias", "Semanas", "Meses"]
    let itemAbono = ["Semanas", "Meses"]
    let itemHabitacion = ["Recamara", "Sala de estar", "Comedor", "Cocina", "Jardin", "Balcon"]
    
    var body: some View {
        
        VStack {
            Spacer(minLength: 50)
            Text("Datos de tu planta:").font(.custom("Noteworthy", size: 40)).foregroundColor(.gray)
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                //Spacer(minLength: 20)
                VStack(alignment: .leading){
                    VStack{
                        //añade fotos
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
                        //nombre
                        VStack{
                            Text("Nombre o apodo:").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            TextField("", text: $nombrePlanta).frame(width: 300, height: 40)
                                .background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        Spacer(minLength: 20)
                        //riego
                        VStack{
                            Text("¿Cada cuanto se debe regar?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            HStack{
                                TextField("", text: $riego).keyboardType(.numberPad).frame(width: 50, height: 40).background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                                Picker("Select one option", selection: $seleccionRiego) {
                                    ForEach(itemRiego, id: \.self) {item in
                                        Text(item)
                                    }
                                }.background(Color("primario")).cornerRadius(10).pickerStyle(SegmentedPickerStyle())
                            }
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        
                        Spacer(minLength: 20)
                    }
                    VStack{
                        //sol
                        VStack{
                                Text("Iluminacion adecuada").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                Picker("Select one option", selection: $seleccionIluminacion) {
                                    ForEach(itemIluminacion, id: \.self) {item in
                                        Text(item)
                                    }
                                }.background(Color("primario")).cornerRadius(10).pickerStyle(SegmentedPickerStyle())
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        Spacer(minLength: 20)
                        
                        //abono
                        VStack{
                            Text("¿Cada cuanto necesita Abono?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            HStack{
                                TextField("", text: $abono).keyboardType(.numberPad).frame(width: 50, height: 40).background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                                Picker("Select one option", selection: $seleccionAbono) {
                                    ForEach(itemAbono, id: \.self) { item in
                                        Text(item)
                                    }
                                }.background(Color("primario")).cornerRadius(10).pickerStyle(SegmentedPickerStyle())
                            }
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        Spacer(minLength: 20)
                        
                        //habitacion
                        VStack{
                                Text("¿En que habitacion se encuentra?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                Picker("Select one option", selection: $seleccionHabitacion) {
                                    ForEach(itemHabitacion, id: \.self) {item in
                                        Text(item).foregroundColor(Color("primario"))
                                    }
                                }.pickerStyle(.wheel)
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

