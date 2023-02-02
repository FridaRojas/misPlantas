//
//  CardIdentifica.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 01/02/23.
//

import SwiftUI

struct CardIdentifica: View {
    var foto : String
    var nombres : [String]
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: foto)){ image in
                image.resizable()
            }placeholder: {
                Image("carga")
            }.padding(.horizontal).frame(width: 200, height: 150)
            VStack{
                Text("Nombre comun")
                    .font(.custom("Noteworthy", size: 10))
                    .foregroundColor(Color.gray)
                ForEach(nombres, id: \.self){nombre in
                    Text(nombre).font(.custom("Noteworthy", size: 15))
                        .foregroundColor(Color.black)
                }
            }.padding(.horizontal).frame(width: 200, height: 50).background(Color.white)
        }.cornerRadius(15)
    }
}

