//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct NavBar: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index : String
    @Binding var menu : Bool
    var body: some View {
        HStack{
            Image("imagen")
                //.(.system(size: device == .phone ? 25 : 35))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text("Mis plantas")
                .font(.custom("Noteworthy", size: 30))
                .bold()
                .foregroundColor(.white)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
            if device == .pad {
                // menu ipad
                HStack(spacing: 25){
                    ButtonView(index: $index, menu: $menu, title: "Sol")
                    ButtonView(index: $index, menu: $menu, title: "Sombra")
                    ButtonView(index: $index, menu: $menu, title: "Ambos")
                }
            }else{
                // menu iphone
                Button(action:{
                    withAnimation{
                        menu.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
            }
                
        }
        .padding(.top, 30)
        .padding()
        .background(Color.yellow)
    }
}


