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
            }.frame(width: 250, height: 250)
            VStack{
                Text("Nombre comun")
                    .font(.custom("Noteworthy", size: 10))
                    .foregroundColor(Color.gray)
                ForEach(nombres, id: \.self){nombre in
                    Text(nombre).font(.custom("Noteworthy", size: 15))
                        .foregroundColor(Color.black)
                }
            }.frame(width: 250, height: 100).background(Color.white)
        }.background(Color.white).cornerRadius(15)
    }
}

