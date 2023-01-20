//
//  Home.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var db = FirebaseViewModel()
    @State private var widthMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    //aqui variable environment para las plantas
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            NavigationView(){
                VStack{
                //NavBar()
                    NavBarHome(nombre: db.Usuario.nombre, numHabitaciones: db.habitacionesShow.count)
                    
                    
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                            VStack (spacing: 15){
                                ForEach (db.habitacionesShow){item in
                                    NavigationLink(destination: Habitacion(habitacion: item)){
                                            CeldaPlantasView(nombreHabitacion: item.nombre, foto: "tipo\(item.tipo)")
                                    }
                                }
                            }.padding()
                    }.onAppear{
                        db.obtieneUsuario()
                        db.obtieneHabitaciones()
                    }
                }.background(Image("fondo1").resizable())
                    .edgesIgnoringSafeArea(.all)
                
            }
        }
    }
}


