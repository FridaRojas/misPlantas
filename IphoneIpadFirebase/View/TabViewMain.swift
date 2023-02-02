//
//  TabViewMain.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//

import SwiftUI

struct TabViewMain: View {
    
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        
        
        ZStack(alignment: .bottom){
            
            VStack(alignment: .center){
                Spacer()
                if loginShow.selectedTab == 0{
                    Home()
                }
                else if loginShow.selectedTab == 1{
                    BuscaView()
                }
                else if loginShow.selectedTab == 2{
                    AgregarPlantaView()
                }
                else if loginShow.selectedTab == 3{
                    Recordatorios()
                }
                else if loginShow.selectedTab == 4{
                    ConfiguracionView()
                }
                else{
                    AgregarHabitacionView()
                }
                
            }.edgesIgnoringSafeArea(.all)
            
            FloatingTabbar()
        }
    }
}

//estructura tab
struct FloatingTabbar : View {
    
    @EnvironmentObject var loginShow : FirebaseViewModel
    @State var agrega = false
    @State private var modalAgregarShow = false
    
    var body : some View{
        if loginShow.tab {
            VStack{
                
                Spacer(minLength: 0)
                
                HStack{
                    
                    Button(action: {
                        loginShow.selectedTab = 0
                    }) {
                        Image(systemName: "house").foregroundColor(loginShow.selectedTab == 0 ? .gray : .white).padding(.horizontal)
                    }
                    
                    Spacer(minLength: 5)
                    
                    Button(action: {
                        loginShow.selectedTab = 1
                    }) {
                        Image(systemName: "magnifyingglass").foregroundColor(loginShow.selectedTab == 1 ? .gray : .white).padding(.horizontal)
                    }
                    
                    Spacer(minLength: 5)
                    
                    Button(action: {
                        agrega.toggle()
                    }) {
                        Image(systemName: "plus").foregroundColor(loginShow.selectedTab == 2 ? .gray : loginShow.selectedTab == 5 ? .gray : .white).padding(.horizontal)
                    }.confirmationDialog("¿Que necesitas agregar?", isPresented: $agrega){
                        Button(action:{
                            loginShow.selectedTab = 2
                        }){
                            Text("Planta")
                        }
                        Button(action:{
                            loginShow.selectedTab = 5
                        }){
                            Text("Habitacion")
                        }
                    }
                    
                    Spacer(minLength: 5)
                    
                    Button(action: {
                        loginShow.selectedTab = 3
                    }) {
                        Image(systemName: "drop").foregroundColor(loginShow.selectedTab == 3 ? .gray : .white).padding(.horizontal)
                    }
                    
                    Spacer(minLength: 5)
                    
                    Button(action: {
                        loginShow.selectedTab = 4
                    }) {
                        Image(systemName: "person").foregroundColor(loginShow.selectedTab == 4 ? .gray : .white).padding(.horizontal)
                    }
                    
                }.padding()
                    .background(Color("primario"))
                    .clipShape(Capsule()).padding(22)
                    .shadow(radius: 5)
                    
            }.edgesIgnoringSafeArea(.bottom)
        }
        
    }
}
