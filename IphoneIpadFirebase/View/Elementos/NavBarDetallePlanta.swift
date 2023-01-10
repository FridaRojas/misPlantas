//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct NavBarDetallePlanta: View {
    var foto : String
    var nombre : String
    
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        VStack {
            HStack{
                Text(nombre)
                    .font(.custom("Noteworthy", size: 40))
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: device == .phone ? 25 : 35))
                    .shadow(radius: 5)
                Spacer()
                    
            }.padding()
            
            /*HStack( spacing: 20){
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
                
            }.padding()*/
            
        }.padding(.top, 300)
            .background(Image(foto).resizable().frame(width: 400, height: 400))
            .cornerRadius(30)
            .shadow(radius: 10)
            .ignoresSafeArea(.all)
    }
}


