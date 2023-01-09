//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct NavBar: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    var body: some View {
        VStack {
            
            
            HStack{
                Image("imagen")
                    //.(.system(size: device == .phone ? 25 : 35))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                Text("Mis plantas")
                    .font(.custom("Noteworthy", size: 40))
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: device == .phone ? 25 : 35))
                Spacer()
                    
            }.padding()
            
            HStack( spacing: 20){
                Spacer()
                
                Button(action:{
                    
                }){
                    Image(systemName: "plus")
                        .padding(10)
                        .foregroundColor(.green.opacity(0.8))
                        .background(Color.white)
                        .font(.largeTitle)
                        .cornerRadius(15)
                        .shadow(radius: 8)
                        
                }
                
            }.padding()
            
        }.padding(.top, 100)
            .background(Image("arriba"))
            .cornerRadius(20)
            .shadow(radius: 4)
    }
}


