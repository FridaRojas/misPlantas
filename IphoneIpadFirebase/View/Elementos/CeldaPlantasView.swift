//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct CeldaPlantasView: View {
    var nombreHabitacion : String
    var foto : String
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading){
                Spacer()
                HStack{
                    Spacer()                }
                Text(nombreHabitacion).font(.custom("Noteworthy", size: 20)).foregroundColor(.black).bold()
            }
        }.padding(.all, 25)
            .frame(height: 120)
            .background(Image(foto).resizable().opacity(0.5))
        //    .background(Color.white.opacity(0.9))
            .cornerRadius(8)
            .shadow(radius: 4)
        
    }
}


