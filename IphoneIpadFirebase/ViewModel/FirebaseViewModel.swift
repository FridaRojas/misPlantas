//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 16/01/23.
//

import Foundation
import FirebaseAuth

class FirebaseViewModel : ObservableObject{
    
    @Published var show = false
    
    func login(email: String, pass: String, completion: @escaping(_ done: Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: pass){ (user, error) in
            if user != nil{
                print("Entro")
                completion(true)
            }else{
                if let error = error?.localizedDescription{
                    print("Error en firebase", error)
                }else{
                    print("error en la aplicacion")
                }
            }
        }
    }
    func crearUsuario(email: String, pass: String, completion: @escaping(_ done: Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: pass){ (user,error) in
            if user != nil{
                completion(true)
            }else{
                if let error = error?.localizedDescription{
                    print("Error en firebase", error)
                }else{
                    print("error en la aplicacion")
                }
            }
        }
    }
    
}
