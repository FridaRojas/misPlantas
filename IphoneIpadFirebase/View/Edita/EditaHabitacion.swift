//
//  EditaHabitacion.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 25/01/23.
//

import SwiftUI

struct EditaHabitacion: View {
    var habitacion : HabitacionModel
    @Binding var modal : Bool
    @State var nombreNuevo = ""
    @State private var seleccionHabitacion: String = "Sala"
    let itemHabitacion = ["Recamara", "Sala", "Comedor", "Cocina", "Jardin", "Balcon"]
    @EnvironmentObject var loginShow : FirebaseViewModel
    @State private var atras = false
    
    var body: some View {
        NavigationStack{
            VStack{
                /*NavigationLink(destination: Home(), isActive: self.$atras){
                 EmptyView()
                 }.navigationBarHidden(true)*/
                
                
                Text("Edita la habitacion")
                    .padding(.horizontal)
                    .font(.custom("Noteworthy", size: 35))
                    .foregroundColor(Color.black)
                //nombre
                VStack{
                    Text("Nombre: ").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                    TextField(habitacion.nombre, text: $nombreNuevo).frame(width: 300, height: 40)
                        .background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                }.padding(.horizontal).onAppear{ nombreNuevo = habitacion.nombre}
                
                //tipo
                VStack{
                    Text("¿Que tipo de habitacion es?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                    Picker("Select one option", selection: $seleccionHabitacion) {
                        ForEach(itemHabitacion, id: \.self) {item in
                            Text(item).foregroundColor(Color("primario"))
                        }
                    }.pickerStyle(.wheel)
                }.padding().onAppear{ seleccionHabitacion = habitacion.tipo}
                
                //Boton
                Button(action:{
                    loginShow.editarHabitacion(nombre: nombreNuevo, tipo: seleccionHabitacion, idHabitacion: habitacion.id){(done) in
                        if done{
                            atras.toggle()
                            modal.toggle()
                        }
                    }
                }){
                    Text("Guardar").foregroundColor(.white).bold()
                }.padding()
                    .background(Color("primario"))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                Spacer(minLength: 20)
            }.background(LinearGradient(gradient: Gradient(colors: [Color("primario"), .white]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea(.all)
                .navigationDestination(isPresented: $atras){
                    Home()
                }
        }
        
    }
}
