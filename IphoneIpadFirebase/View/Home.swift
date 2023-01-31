//
//  Home.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var loginShow : FirebaseViewModel
    @State var progress = true
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            NavigationStack{
                VStack{
                    NavBarHome(nombre: loginShow.Usuario.nombre, numHabitaciones: loginShow.habitacionesShow.count)
                    
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                            VStack (spacing: 15){
                                ForEach (loginShow.habitacionesShow){item in
                                    Button(action:{
                                        //navegacion = true
                                        loginShow.mandaItem(habitacion: item)
                                    }){
                                        CeldaPlantasView(nombreHabitacion: item.nombre, foto: "tipo\(item.tipo)")
                                    }.navigationDestination(isPresented: $loginShow.NavegacionHabitacion){
                                        Habitacion()
                                    }
                                    /*NavigationLink(destination: Habitacion(habitacion: item, navegacion: $navegacion)){
                                            CeldaPlantasView(nombreHabitacion: item.nombre, foto: "tipo\(item.tipo)")
                                    }*/
                                }
                            }.padding()
                        Spacer(minLength: 40)
                    }
                }.background(Image("fondo1").resizable())
                    .edgesIgnoringSafeArea(.all)
                    .onAppear{
                    loginShow.obtieneUsuario()
                    loginShow.obtieneHabitaciones()
                }
                
            }
            
            if loginShow.habitacionesShow.isEmpty {
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
                }.background(Color.white.opacity(0.9)).ignoresSafeArea(.all)
            }
        }
    }
}


