//
//  Home.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct Home: View {
    @State private var index = "Sol"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    func getColumns() -> Int{
        return (device == .pad) ? 4 : ((device == .phone && width == .regular) ? 4 : 2)
    }
    
    var body: some View {
        ZStack{
            VStack{
                NavBar(index: $index, menu: $menu)
                ZStack{
                    if index == "Sol" {
                        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: getColumns()), spacing: 2){
                                ForEach(1...9, id:\.self){ _ in
                                    CardView()
                                        .padding(.all)
                                }
                            }
                        }
                    }else if index == "Sombra"{
                        VStack{
                            Color.green
                        }
                    }else{
                        VStack{
                            Color.red
                        }
                    }
                }
            }
            // termina navbar ipad
            if menu {
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                            Spacer()
                            Button(action:{
                                withAnimation{
                                    menu.toggle()
                                }
                            }){
                                Image(systemName: "xmark")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }.padding()
                        .padding(.top, 50)
                        VStack(alignment: .trailing, spacing: 15){
                            ButtonView(index: $index, menu: $menu, title: "Sol")
                            ButtonView(index: $index, menu: $menu, title: "Sombra")
                            ButtonView(index: $index, menu: $menu, title: "Ambos")
                        }
                        Spacer()
                    }
                    .frame(width: widthMenu - 200)
                    .background(Color.yellow)
                }
            }
        }.background(Image("fondo").resizable())
        //background(Color.white.opacity(0.9))
    }
}


