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
            
            VStack{
                //NavBar()
                SaludoNavBar()
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: getColumns()), spacing: 2){
                        ForEach(1...9, id:\.self){ _ in
                            CardView()
                                .padding(.all)
                        }
                    }
                }
            }.background(Image("fondo1").resizable())
                .edgesIgnoringSafeArea(.all)
        }
    }
}


