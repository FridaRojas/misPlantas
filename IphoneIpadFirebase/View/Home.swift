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
                            NavigationLink(destination: Habitacion(nombreHabitacion: "Recamara 1", numeroPlantas: "3")){
                                CeldaPlantasView(nombreHabitacion: "Recamara 1", imagen: "fondoHabitacion1")
                            }
                            CeldaPlantasView(nombreHabitacion: "Recamara 2", imagen: "fondoHabitacion1")
                            CeldaPlantasView(nombreHabitacion: "Recamara 3", imagen: "fondoHabitacion1")
                            CeldaPlantasView(nombreHabitacion: "Recamara 4", imagen: "fondoHabitacion1")
                            CeldaPlantasView(nombreHabitacion: "Recamara 5", imagen: "fondoHabitacion1")
                            CeldaPlantasView(nombreHabitacion: "Recamara 6", imagen: "fondoHabitacion1")
                        }.padding()
                        
                    }
                }.background(Image("fondo1").resizable())
                    .edgesIgnoringSafeArea(.all)
                
            }
        }
    }
}


