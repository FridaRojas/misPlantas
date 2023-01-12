//
//  Home.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct Home: View {
    @State private var widthMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    //aqui variable environment para las plantas
    
    func getColumns() -> Int{
        return (device == .pad) ? 4 : ((device == .phone && width == .regular) ? 4 : 2)
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            NavigationView(){
                VStack{
                //NavBar()
                    NavBarHome()
                
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                        VStack (spacing: 15){
                            NavigationLink(destination: Habitacion(nombreHabitacion: "Recamara1", numeroPlantas: "3", tipoHabitacion: "Recamara")){
                                CeldaPlantasView(nombreHabitacion: "Recamara 1", imagen: "fondoHabitacion1")
                            }
                            NavigationLink(destination: Habitacion(nombreHabitacion: "Sala", numeroPlantas: "3", tipoHabitacion: "Sala")){
                                CeldaPlantasView(nombreHabitacion: "Sala", imagen: "fondoHabitacion1")
                            }
                            NavigationLink(destination: Habitacion(nombreHabitacion: "Cocina", numeroPlantas: "3", tipoHabitacion: "Cocina")){
                                CeldaPlantasView(nombreHabitacion: "Cocina", imagen: "fondoHabitacion1")
                            }
                            NavigationLink(destination: Habitacion(nombreHabitacion: "Comedor", numeroPlantas: "3", tipoHabitacion: "Comedor")){
                                CeldaPlantasView(nombreHabitacion: "Comedor", imagen: "fondoHabitacion1")
                            }
                            NavigationLink(destination: Habitacion(nombreHabitacion: "Jardin", numeroPlantas: "3", tipoHabitacion: "Jardin")){
                                CeldaPlantasView(nombreHabitacion: "Jardin", imagen: "fondoHabitacion1")
                            }
                            NavigationLink(destination: Habitacion(nombreHabitacion: "Balcon", numeroPlantas: "3", tipoHabitacion: "Balcon")){
                                CeldaPlantasView(nombreHabitacion: "Balcon", imagen: "fondoHabitacion1")
                            }
                        }.padding()
                        
                    }
                }.background(Image("fondo1").resizable())
                    .edgesIgnoringSafeArea(.all)
                
            }
        }
    }
}


