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
import GoogleSignIn
import GoogleSignInSwift
import GoogleUtilities

class FirebaseViewModel : ObservableObject{
    
    @Published var show = false
    @Published var tab = true
    @Published var NavegacionHabitacion = false
    @Published var NavegacionPlanta = false
    @Published var selectedTab = 0
    @Published var habitacionesShow = [HabitacionModel]()
    @Published var plantasActuales = [PlantasModel]()
    //@Published var recordatoriosShow = [RecordatorioModel]()
    @Published var Usuario = UsuarioModel(id: "  ", nombre: "   ", correo: "   ", foto: "   ")
    @Published var habitacionActual = HabitacionModel(id: "   ", nombre: "   ", tipo: "   ")
    @Published var plantaActual = PlantasModel(id: "", nombre: "", foto: "", iluminacion: "", abonoNum: 0, abonoPeriod: "", proxRecordatorio: Date(), riegoNum: 0, riegoPeriod: "")
    
    //AUTENTICACION POR CORREO
    func login(email: String, pass: String, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        Auth.auth().signIn(withEmail: email, password: pass){ (user, error) in
            if user != nil{
                print("Entro")
                guard let id = Auth.auth().currentUser?.uid else {return}
                self.Usuario.id = id
                success(true)
            }else{
                failure(error!)
                if let error = error?.localizedDescription{
                    print("Error en firebase", error)
                }else{
                    print("error en la aplicacion")
                }
            }
        }
    }
    func crearUsuario(correo: String, pass: String, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        Auth.auth().createUser(withEmail: correo, password: pass){ (user,error) in
            if user != nil{
                print("cree usuario en auth")
                success(true)
            }else{
                failure(error!)
                if let error = error?.localizedDescription{
                    print("Error en firebase", error)
                }else{
                    print("error en la aplicacion")
                }
            }
        }
    }
    
    //GUARDA EN BASE DE DATOS
    func AgregarUsuario(nombre: String, correo: String, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        let db = Firestore.firestore() //crea conexion
        print("entre a agregar fire, idMANDA:\(self.Usuario.id)")
        
        let campos : [String:Any] = ["nombre": nombre, "correo": correo, "foto": "gs://fir-crud-af577.appspot.com/imagenes/perfil-de-usuario.png"]
        print("nombre: \(nombre) , correo: \(correo)")
        db.collection("Usuarios").document(self.Usuario.id).setData(campos){error in
            if let error = error{
                failure(error)
            }else{
                print("guardo")
                success(true)
            }
        }
        
    }
    
    ////////////////////// FALTA PONER LA ALerta
    func AgregarHabitacion(nombre: String, tipo: String, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        let db = Firestore.firestore() //crea conexion
        let id = UUID().uuidString
        let campos : [String:Any] = ["nombre": nombre, "tipo": tipo]
        
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(id).setData(campos){error in
            if let error = error{
                failure(error)
            }else{
                print("guardo")
                success(true)
            }
        }
        
    }
    func AgregarPlantas(idHabitacion:String, nombre: String, foto: Data, iluminacion: String, riegoNum: Int, riegoPeriod: String, abonoNum: Int, abonoPeriod: String, proxRecordatorio: Date, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        
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
                print("estoy agregando los datos: id:\(self.Usuario.id), idHabitacion: \(idHabitacion)")
                print("lo que guardare es: \(nombre)")
                db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).collection("Plantas").document(id).setData(campos){error in
                    if let error = error{
                        failure(error)
                    }else{
                        print("guardo")
                        success(true)
                    }
                }
            }else{
                failure(error!)
                if let error = error?.localizedDescription{
                    print("fallo al subir en storage", error)
                }else{
                    print("fallo de la app")
                }
            }
        }
    }
    
    //LEE DE BASE DE DATOS
    func obtieneHabitaciones(success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        //var plantas = [PlantasModel]()
        let  db = Firestore.firestore()
        //print("entre a obtiene habitaciones, id: \(self.Usuario.id)")
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").getDocuments{(QuerySnapshot, error) in
            //print("consulta correcta, traje: \(QuerySnapshot?.count)")
            if let error = error{
                print("error al mostrar datos", error)
                failure(error)
            }else{
                //print("borro habitaciones")
                self.habitacionesShow.removeAll()
                for document in QuerySnapshot!.documents{
                    let valor = document.data()
                    let id = document.documentID
                    let nombre = valor["nombre"] as? String ?? "Sin nombre"
                    let tipo = valor["tipo"] as? String ?? "Recamara"
                        let registros = HabitacionModel(id: id, nombre: nombre, tipo: tipo)
                        self.habitacionesShow.append(registros)
                    
                }
                success(true)
            }
        }
    }
    func obtienePlantas(idHabitacion : String, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        plantasActuales = [PlantasModel]()
        let  db = Firestore.firestore()
        
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).collection("Plantas").getDocuments(){(QuerySnapshot, error) in
            if let error = error{
                print("error al mostrar datos", error)
                failure(error)
            }else{
                for document in QuerySnapshot!.documents{
                    let valor = document.data()
                    let id = document.documentID
                    let nombre = valor["nombre"] as? String ?? "Sin nombre"
                    let foto = valor["foto"] as? String ?? "Sin Foto"
                    let iluminacion = valor["iluminacion"] as? String ?? "Sol"
                    let abonoNum = valor["abonoNum"] as? Int ?? 0
                    let abonoPeriod = valor["abonoPeriod"] as? String ?? "mes"
                    guard let time = valor["proxRecordatorio"] as? Timestamp else {
                        return
                    }
                    let proxRecordatorio = time.dateValue()
                    let riegoNum = valor["riegoNum"] as? Int ?? 0
                    let riegoPeriod = valor["riegoPeriod"] as? String ?? "dia"
                        let registros = PlantasModel(id: id, nombre: nombre, foto: foto, iluminacion: iluminacion, abonoNum: abonoNum, abonoPeriod: abonoPeriod, proxRecordatorio: proxRecordatorio, riegoNum: riegoNum, riegoPeriod: riegoPeriod)
                        self.plantasActuales.append(registros)
                }
                success(true)
            }
        }
    }
    func obtieneUsuario(success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        //var plantas = [PlantasModel]()
        let  db = Firestore.firestore()
        guard let id = Auth.auth().currentUser?.uid else {return}
        self.Usuario.id = id
        db.collection("Usuarios").document(self.Usuario.id).getDocument{(document, error) in
            if let error = error{
                failure(error)
                print("error al mostrar datos", error)
            }else{
                let valor = document!.data()
                self.Usuario.nombre = valor?["nombre"] as? String ?? "Sin nombre"
                self.Usuario.foto = valor?["foto"] as? String ?? "Recamara"
                self.Usuario.correo = valor?["correo"] as? String ?? "nadie.com"
                
                success(true)
            }
        }
    }
    func obtieneRecordatorios(success : @escaping(_ resultado: [RecordatorioModel]) ->(), failure: @escaping (_ error: Error) -> ()){
        let  db = Firestore.firestore()
        var recordatoriosShow = [RecordatorioModel]()
        
        //para cada habitacion obtiene sus recordatorios
        for habitacion in self.habitacionesShow{
            
            db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(habitacion.id).collection("Plantas").getDocuments(){(QuerySnapshot, error) in
                if let error = error{
                    print("error al mostrar datos", error)
                    failure(error)
                }else{
                    for document in QuerySnapshot!.documents{
                        let valor = document.data()
                        let id = document.documentID
                        let nombre = valor["nombre"] as? String ?? "Sin nombre"
                        guard let time = valor["proxRecordatorio"] as? Timestamp else {
                            return 
                        }
                        let proxRecordatorio = time.dateValue()
                        let tipo = "Riego"
                        let registros = RecordatorioModel(id: id, planta: nombre, tipo: tipo, fecha: proxRecordatorio)
                        recordatoriosShow.append(registros)
                    }
                    success(recordatoriosShow)
                }
            }
            

        }
    }
    
    // Eliminar DE BASE DE DATOS
    func eliminarPlanta(item : PlantasModel, idHabitacion: String){
        //eliminar firestore
        let id = item.id
        let db = Firestore.firestore()
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).collection("Plantas").document(id).delete()
        //eliminar storage
        let imagen = item.foto
        let borrarImagen = Storage.storage().reference(forURL: imagen)
        borrarImagen.delete(completion: nil)
    }
    func eliminarHabitacion(item : HabitacionModel){
        //eliminar firestore
        let id = item.id
        let db = Firestore.firestore()
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(id).delete()
       
    }
    
    //EDITAR DE BASE DE DATOS
    func editarHabitacion(nombre: String, tipo: String, idHabitacion : String, completion: @escaping (_ done : Bool) -> Void){
        let db = Firestore.firestore()
        let campos : [String:Any] = ["nombre": nombre, "tipo": tipo]
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).updateData(campos){error in
            if let error = error?.localizedDescription{
                print(error)
            }else{
                completion(true)
            }
        }
    }
    func editarPlantaFotoNombre(idHabitacion :String, Planta: PlantasModel, nombreNuevo : String, fotoNuevo : Data?, riegoNum: Int, riegoPeriod : String, siguienteRiego : Date, completion: @escaping (_ done : Bool) -> Void){
        if fotoNuevo != nil{
            //eliminar imagen
            let imagen = Planta.foto
            let borrarImagen = Storage.storage().reference(forURL: imagen)
            borrarImagen.delete(completion: nil)
            //subir nueva imagen
            let storage = Storage.storage().reference()
            let nombreImagen = UUID()
            let directorio = storage.child("imagenes/\(nombreImagen)")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            directorio.putData(fotoNuevo!, metadata: metadata){data, error in
                if error == nil{
                    //Ya que guardo imagen, edita lo demas
                    let db = Firestore.firestore()
                    let campos : [String:Any] = ["nombre": nombreNuevo, "foto": String(describing: directorio), "riegoNum": riegoNum, "riegoPeriod":riegoPeriod, "proxRecordatorio":siguienteRiego]
                    db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).collection("Plantas").document(Planta.id).updateData(campos){error in
                        if let error = error?.localizedDescription{
                            print(error)
                        }else{
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
        }else{
            let db = Firestore.firestore()
            let campos : [String:Any] = ["nombre": nombreNuevo, "riegoNum": riegoNum, "riegoPeriod":riegoPeriod, "proxRecordatorio":siguienteRiego]
            db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).collection("Plantas").document(Planta.id).updateData(campos){error in
                if let error = error?.localizedDescription{
                    print(error)
                }else{
                    completion(true)
                }
            }
        }
        
    }
    func editarUsuario(nombreNuevo : String, fotoNuevo : Data?, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        
        if fotoNuevo != nil{
            let imagen = self.Usuario.foto
            
            //eliminar imagen si no es la de defecto
            if imagen != "gs://fir-crud-af577.appspot.com/imagenes/perfil-de-usuario.png"{
                let borrarImagen = Storage.storage().reference(forURL: imagen)
                borrarImagen.delete(completion: nil)
            }
            //subir nueva imagen
            let storage = Storage.storage().reference()
            let nombreImagen = UUID()
            let directorio = storage.child("imagenes/\(nombreImagen)")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            directorio.putData(fotoNuevo!, metadata: metadata){data, error in
                if error == nil{
                    //Ya que guardo imagen, edita
                    let db = Firestore.firestore()
                    let campos : [String:Any] = ["nombre": nombreNuevo, "foto": String(describing: directorio)]
                    db.collection("Usuarios").document(self.Usuario.id).updateData(campos){error in
                        if let error = error{
                            failure(error)
                            print(error)
                        }else{
                            success(true)
                        }
                    }
                }else{
                    failure(error!)
                    if let error = error?.localizedDescription{
                        print("fallo al subir en storage", error)
                    }else{
                        print("fallo de la app")
                    }
                }
            }
        }else{ //si no manda imagen, solo actualiza nombre
            let db = Firestore.firestore()
            let campos : [String:Any] = ["nombre": nombreNuevo]
            db.collection("Usuarios").document(self.Usuario.id).updateData(campos){error in
                if let error = error?.localizedDescription{
                    print(error)
                }else{
                    success(true)
                }
            }
        }
       
        
        
        
        
    }
    
    //FUNCIONALIDADES SIN BD
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
    func actualizaPlanta(idPlanta: String, idHabitacion: String) -> PlantasModel {
        var planta = PlantasModel(id: "", nombre: "", foto: "", iluminacion: "", abonoNum: 0, abonoPeriod: "", proxRecordatorio: Date(), riegoNum: 0, riegoPeriod: "")
        
        let  db = Firestore.firestore()
        
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).collection("Plantas").document(idPlanta).getDocument(){(Documento, error) in
            if let error = error?.localizedDescription{
                print("error al mostrar datos", error)
            }else{
                    let valor = Documento!.data()
                    let nombre = valor?["nombre"] as? String ?? "Sin nombre"
                    let foto = valor?["foto"] as? String ?? "Sin Foto"
                    let iluminacion = valor?["iluminacion"] as? String ?? "Sol"
                    let abonoNum = valor?["abonoNum"] as? Int ?? 0
                    let abonoPeriod = valor?["abonoPeriod"] as? String ?? "mes"
                    let proxRecordatorio = valor?["proxRecordatorio"] as? Date ?? Date()
                    let riegoNum = valor?["riegoNum"] as? Int ?? 0
                    let riegoPeriod = valor?["riegoPeriod"] as? String ?? "dia"
                print("edite la planta: \(nombre) con url: \(foto)")
                    //DispatchQueue.main.async {
                        let registros = PlantasModel(id: idPlanta, nombre: nombre, foto: foto, iluminacion: iluminacion, abonoNum: abonoNum, abonoPeriod: abonoPeriod, proxRecordatorio: proxRecordatorio, riegoNum: riegoNum, riegoPeriod: riegoPeriod)
                        planta = registros
                    //}
                
            }
        }
        return planta
    }
    func mandaItem(habitacion : HabitacionModel){
        habitacionActual = habitacion
        NavegacionHabitacion.toggle()
    }
    func mandaItemPlanta(planta : PlantasModel){
        plantaActual = planta
        NavegacionPlanta.toggle()
    }
    func devuelveRecordatorio(dia : Date, recordatorios: [RecordatorioModel]) -> [RecordatorioModel]{
        var recordatoriosDia = [RecordatorioModel]()
        
        for recordatorio in recordatorios{
            if recordatorio.fecha.formatted(date: .numeric, time: .omitted) == dia.formatted(date: .numeric, time: .omitted){
                recordatoriosDia.append(recordatorio)
            }
        }
        return recordatoriosDia
    }
    func existeRecordatorio(dia : Date, recordatorios: [RecordatorioModel]) -> Bool{
        let recordatorios = devuelveRecordatorio(dia: dia, recordatorios: recordatorios)
        if recordatorios.isEmpty{
            return false
        }else{
            return true
        }
    }
    func limpiaResultados(resultados: [Result]) ->[Result] {
        var resultadosLimpios = [Result]()
        
        for resultado in resultados {
            if !(resultado.species.commonNames.isEmpty){
                resultadosLimpios.append(resultado)
            }
        }
        
        return resultadosLimpios
    }
}
