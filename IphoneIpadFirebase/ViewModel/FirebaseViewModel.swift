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
    @Published var Usuario = UsuarioModel(id: "111", nombre: "111", correo: "111", foto: "111")
    @Published var habitacionesShow = [HabitacionModel]()
    @Published var plantaActual = [PlantasModel]()
    
    //AUTENTICACION POR CORREO
    func login(email: String, pass: String, completion: @escaping(_ done: Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: pass){ (user, error) in
            if user != nil{
                print("Entro")
                guard let id = Auth.auth().currentUser?.uid else {return}
                self.Usuario.id = id
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
    func crearUsuario(correo: String, pass: String, completion: @escaping(_ done: Bool) -> Void){
        Auth.auth().createUser(withEmail: correo, password: pass){ (user,error) in
            if user != nil{
                print("cree usuario en auth")
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
    
    //GUARDA EN BASE DE DATOS
    func AgregarUsuario(nombre: String, correo: String, completion: @escaping (_ done : Bool) -> Void){
        let db = Firestore.firestore() //crea conexion
        print("entre a agregar fire, idMANDA:\(self.Usuario.id)")
        
        let campos : [String:Any] = ["nombre": nombre, "correo": correo, "foto": "gs://fir-crud-af577.appspot.com/imagenes/perfil-de-usuario.png"]
        print("nombre: \(nombre) , correo: \(correo)")
        db.collection("Usuarios").document(self.Usuario.id).setData(campos){error in
            if let error = error?.localizedDescription{
                print(error)
                print("fueeeee")
            }else{
                print("guardo en fire")
                completion(true)
            }
        }
        
    }
    
    func AgregarHabitacion(nombre: String, tipo: String, completion: @escaping (_ done : Bool) -> Void){
        let db = Firestore.firestore() //crea conexion
        let id = UUID().uuidString
        let campos : [String:Any] = ["nombre": nombre, "tipo": tipo]
        
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(id).setData(campos){error in
            if let error = error?.localizedDescription{
                print(error)
            }else{
                print("guardo")
                completion(true)
            }
        }
        
    }
    
    func AgregarPlantas(idHabitacion:String, nombre: String, foto: Data, iluminacion: String, riegoNum: Int, riegoPeriod: String, abonoNum: Int, abonoPeriod: String, proxRecordatorio: Date, completion: @escaping (_ done : Bool) -> Void){
        
        let storage = Storage.storage().reference()
        let nombreImagen = UUID()
        let directorio = storage.child("imagenes/\(nombreImagen)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directorio.putData(foto, metadata: metadata){data, error in
            if error == nil{
                //Ya que guardo imagen, guarda lo demas
                let db = Firestore.firestore() //crea conexion
                let id = UUID().uuidString
                let campos : [String:Any] = ["nombre": nombre, "foto": String(describing: directorio), "iluminacion": iluminacion, "riegoNum": riegoNum, "riegoPeriod": riegoPeriod, "abonoNum": abonoNum, "abonoPeriod": abonoPeriod, "proxRecordatorio": proxRecordatorio]
                
                db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).collection("Plantas").document(id).setData(campos){error in
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
    
    //LEE DE BASE DE DATOS
    func obtieneHabitaciones(){
        //var plantas = [PlantasModel]()
        let  db = Firestore.firestore()
        
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").getDocuments{(QuerySnapshot, error) in
            if let error = error?.localizedDescription{
                print("error al mostrar datos", error)
            }else{
                self.habitacionesShow.removeAll()
                for document in QuerySnapshot!.documents{
                    let valor = document.data()
                    let id = document.documentID
                    let nombre = valor["nombre"] as? String ?? "Sin nombre"
                    let tipo = valor["tipo"] as? String ?? "Recamara"
                    //DispatchQueue.main.async {
                        //plantas = self.obtienePlantas(iUsuario: iUsuario, idHabitacion: id)
                        let registros = HabitacionModel(id: id, nombre: nombre, tipo: tipo)
                        self.habitacionesShow.append(registros)
                    //}
                }
            }
        }
    }
    
    func obtienePlantas(idHabitacion : String){
        plantaActual = [PlantasModel]()
        let  db = Firestore.firestore()
        
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).collection("Plantas").getDocuments(){(QuerySnapshot, error) in
            if let error = error?.localizedDescription{
                print("error al mostrar datos", error)
            }else{
                for document in QuerySnapshot!.documents{
                    let valor = document.data()
                    let id = document.documentID
                    let nombre = valor["nombre"] as? String ?? "Sin nombre"
                    let foto = valor["foto"] as? String ?? "Sin Foto"
                    let iluminacion = valor["iluminacion"] as? String ?? "Sol"
                    let abonoNum = valor["abonoNum"] as? Int ?? 0
                    let abonoPeriod = valor["abonoPeriod"] as? String ?? "mes"
                    let proxRecordatorio = valor["proxRecordatorio"] as? Date ?? Date()
                    let riegoNum = valor["riegoNum"] as? Int ?? 0
                    let riegoPeriod = valor["riegoPeriod"] as? String ?? "dia"
                    //DispatchQueue.main.async {
                        let registros = PlantasModel(id: id, nombre: nombre, foto: foto, iluminacion: iluminacion, abonoNum: abonoNum, abonoPeriod: abonoPeriod, proxRecordatorio: proxRecordatorio, riegoNum: riegoNum, riegoPeriod: riegoPeriod)
                        print("registrosNombre\(registros.nombre)")
                        print("registrosfoto",registros.foto)
                        self.plantaActual.append(registros)
                    //}
                }
            }
        }
    }
    
    func obtieneUsuario(){
        //var plantas = [PlantasModel]()
        let  db = Firestore.firestore()
        guard let id = Auth.auth().currentUser?.uid else {return}
        self.Usuario.id = id
        print("estoy en obtieneUsuario y el id es : \(self.Usuario.id)")
        db.collection("Usuarios").document(self.Usuario.id).getDocument{(document, error) in
            if let error = error?.localizedDescription{
                print("error al mostrar datos", error)
            }else{
                let valor = document!.data()
                self.Usuario.nombre = valor?["nombre"] as? String ?? "Sin nombre"
                self.Usuario.foto = valor?["tipo"] as? String ?? "Recamara"
                self.Usuario.correo = valor?["correo"] as? String ?? "nadie.com"
                //guard let idUser = Auth.auth().currentUser?.uid else {return} //obtiene id del usuario en la autentificacion
                //self.Usuario.id = idUser
            }
        }
    }
    
    //FUNCIONALIDADES
    
    func devuelveNombres() -> [String] {
        var nombres = [String]()
        for habitacion in self.habitacionesShow {
            nombres.append(habitacion.nombre)
        }
        return nombres
    }
    func devuelveId(nombre : String) -> String{
        var id = ""
        for habitacion in self.habitacionesShow {
            if habitacion.nombre == nombre{
                id = habitacion.id
            }
        }
        return id
    }
    
}
