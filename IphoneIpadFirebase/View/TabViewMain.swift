//
//  TabViewMain.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//

import SwiftUI

struct TabViewMain: View {
    @State var selected = 0
    
    var body: some View {
        
        
        ZStack(alignment: .bottom){
            
            VStack(alignment: .center){
                Spacer()
                if self.selected == 0{
                    Home()
                }
                else if self.selected == 1{
                    BuscaView()
                }
                else if self.selected == 2{
                    AgregarPlantaFotoView()
                }
                else if self.selected == 3{
                    RecordatoriosView()
                }
                else if self.selected == 4{
                    ConfiguracionView()
                }
                else if self.selected == 5{
                    AgregarPlantaView()
                }
                else{
                    AgregarHabitacionView()
                }
                
            }.edgesIgnoringSafeArea(.all)
            
            FloatingTabbar(selected: self.$selected)
        }
    }
}

//estructura tab
struct FloatingTabbar : View {
    
    @Binding var selected : Int
    @State private var modalAgregarShow = false
    
    var body : some View{
        
        VStack{
            
            Spacer(minLength: 0)
            
            HStack{
                
                Button(action: {
                    self.selected = 0
                }) {
                    Image(systemName: "house").foregroundColor(self.selected == 0 ? .gray : .white).padding(.horizontal)
                }
                
                Spacer(minLength: 5)
                
                Button(action: {
                    self.selected = 1
                }) {
                    Image(systemName: "magnifyingglass").foregroundColor(self.selected == 1 ? .gray : .white).padding(.horizontal)
                }
                
                Spacer(minLength: 5)
                
                Button(action: {
                    //self.selected = 2
                    //modalAgregarShow.toggle()
                }) {
                    Image(systemName: "plus").foregroundColor(self.selected == 2 ? .gray : self.selected == 5 ? .gray : self.selected == 6 ? .gray : .white).padding(.horizontal)
                }.contextMenu(ContextMenu(menuItems: {
                    Button(action:{
                        self.selected = 2
                    },label:{
                        Label("Planta por foto", systemImage: "camera")
                    })
                    Button(action:{
                        self.selected = 5
                    },label:{
                        Label("Planta manual", systemImage: "camera.macro")
                    })
                    Button(action:{
                        self.selected = 6
                    },label:{
                        Label("Habitacion", systemImage: "window.awning.closed")
                    })
                }))
                
                Spacer(minLength: 5)
                
                Button(action: {
                    self.selected = 3
                }) {
                    Image(systemName: "drop").foregroundColor(self.selected == 3 ? .gray : .white).padding(.horizontal)
                }
                
                Spacer(minLength: 5)
                
                Button(action: {
                    self.selected = 4
                }) {
                    Image(systemName: "person").foregroundColor(self.selected == 4 ? .gray : .white).padding(.horizontal)
                }
                
            }.padding()
                .background(Color("primario"))
                .clipShape(Capsule()).padding(22)
                .shadow(radius: 5)
        }.edgesIgnoringSafeArea(.bottom)
    }
}
