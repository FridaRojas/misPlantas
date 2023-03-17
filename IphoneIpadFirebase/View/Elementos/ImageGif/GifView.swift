//
//  GifView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 17/03/23.
//

import SwiftUI

struct GifView: View {
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Spacer()
                GifImage("espere")
                    .frame(width: 150, height: 150)
                    .cornerRadius(90)
                Spacer()
            
            }
            Spacer()
        }.background(Color.white.opacity(0.9)).ignoresSafeArea(.all)
    }
}

