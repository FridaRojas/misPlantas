//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 16/01/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirebaseViewModel : ObservableObject{
    
    @Published var show = false
    
    //AUTENTICACION POR CORREO
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
    
    //BASE DE DATOS
    func AgregarUsuario(Nombre: String, Correo: String, completion: @escaping (_ done : Bool) -> Void){
        let db = Firestore.firestore() //crea conexion
        let id = UUID().uuidString
        guard let idUser = Auth.auth().currentUser?.uid else {return}
        let campos : [String:Any] = ["Nombre": Nombre, "Correo": Correo]
        db.collection("Usuarios").document(id).setData(campos){error in
            if let error = error?.localizedDescription{
                print(error)
            }else{
                print("guardo")
                completion(true)
            }
        }
        
    }
    
    func AgregarHabitacion(Nombre: String, Tipo: String, IdUsuario: String, completion: @escaping (_ done : Bool) -> Void){
        let db = Firestore.firestore() //crea conexion
        let id = UUID().uuidString
        let campos : [String:Any] = ["Nombre": Nombre, "Tipo": Tipo]
        
        db.collection("Usuarios").document(IdUsuario).collection("Habitacion").document(id).setData(campos){error in
            if let error = error?.localizedDescription{
                print(error)
            }else{
                print("guardo")
                completion(true)
            }
        }
        
    }
    
    func AgregarPlantas(IdUsuario: String, IdHabitacion:String, Nombre: String, Foto: Data, Iluminacion: String, RiegoNum: Int, RiegoPeriod: String, AbonoNum: Int, AbonoPeriod: String, ProxRecordatorio: Date, completion: @escaping (_ done : Bool) -> Void){
        
        let storage = Storage.storage().reference()
        let nombreImagen = UUID()
        let directorio = storage.child("imagenes/\(nombreImagen)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directorio.putData(Foto, metadata: metadata){data, error in
            if error == nil{
                //Ya que guardo imagen, guarda lo demas
                let db = Firestore.firestore() //crea conexion
                let id = UUID().uuidString
                let campos : [String:Any] = ["Nombre": Nombre, "Foto": String(describing: directorio), "Iluminacion": Iluminacion, "RiegoNum": RiegoNum, "RiegoPeriod": RiegoPeriod, "AbonoNum": AbonoNum, "AbonoPeriod": AbonoPeriod, "ProxRecordatorio": ProxRecordatorio]
                
                db.collection("Usuarios").document(IdUsuario).collection("Habitacion").document(IdHabitacion).collection("Plantas").document(id).setData(campos){error in
                    if let error = error?.localizedDescription{
                        print(error)
                    }else{
                        print("guardo")
                        completion(true)
                    }
                }
            }else{
                if let error = error?.localizedDescription{
                    print("fallo al subir en storage", error)
                }else{
                    print("fallo de la app")
                }
            }
        }
        
        
        
        /**/
        
    }
}
