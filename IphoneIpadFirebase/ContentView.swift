//
//  ContentView.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    var body: some View {
        return Group{
            if loginShow.show{
                TabViewMain()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            }else{
                Login()
            }
        }.onAppear{
            if(UserDefaults.standard.object(forKey: "sesion")) != nil{
                loginShow.show = true
                guard let id = Auth.auth().currentUser?.uid else {return}
                loginShow.Usuario.id = id
            }
        }
            
        
    }
}


