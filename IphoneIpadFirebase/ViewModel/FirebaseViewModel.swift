//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 16/01/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import GoogleSignIn
import FacebookLogin

class FirebaseViewModel : ObservableObject{
    
    @Published var show = false
    @Published var tab = true
    @Published var NavegacionHabitacion = false
    @Published var NavegacionPlanta = false
    @Published var selectedTab = 0
    @Published var habitacionesShow = [HabitacionModel]()
    @Published var plantasActuales = [PlantasModel]()
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
                /*if let error = error?.localizedDescription{
                    print("Error en firebase", error)
                }else{
                    print("error en la aplicacion")
                }*/
            }
        }
    }
    func restablecerContras(email : String, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        Auth.auth().sendPasswordReset(withEmail: email){ (error) in
            if let error = error{
                failure(error)
            }else{
                print("envio el correo")
                success(true)
            }
        }
    }
    
    //AUTNTICACION POR GOOGLE
    func iniciaGoogle(presenting : UIViewController, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config
                
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { signResult, error in
                    
            if let error = error {
               failure(error)
               return
            }

            guard let user = signResult?.user,
                      let idToken = user.idToken else { return }
                
                let accessToken = user.accessToken
                       
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)

          // ...
            Auth.auth().signIn(with: credential){ result, error in
                guard error == nil else{
                    return
                }
                print("creo sesion desde google en firebase")
                success(true)
            }
        }
    }
    func obtieneDatosGoogle(){
        // Obtener la instancia actual del usuario que ha iniciado sesión con Google
        guard let usuario = Auth.auth().currentUser else {return}

        // Obtener los datos adicionales del usuario de Google
        guard let proveedorDeDatos = usuario.providerData.first(where: { $0.providerID == GoogleAuthProviderID }) else {return}

        // Acceder a los datos del usuario de Google
        let uid = usuario.uid // El ID del usuario en Firebase Auth
        let nombre = proveedorDeDatos.displayName // El nombre del usuario
        let email = proveedorDeDatos.email // El correo electrónico del usuario
        
        self.Usuario.id = uid
        self.Usuario.nombre = nombre ?? "Sin nombre"
        self.Usuario.correo = email ?? "nadie.com"
    }
    
    //AUTENTICACION POR FACEBOOK
    func iniciaFacebook(success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["email"], from: nil){ loginManagerResult, error in
            
            if let error = error{
                print("error al iniciar con facebook")
                failure(error)
            }
            let token = loginManagerResult?.token?.tokenString
            //success(true)
            let credencial = FacebookAuthProvider.credential(withAccessToken: token!)
            Auth.auth().signIn(with: credencial){ dataResult, error in
                if let error = error{
                    print("error al iniciar con facebook en firebase")
                    failure(error)
                }
                let id = dataResult?.user.uid ?? "No id"
                let nombre = dataResult?.user.displayName ?? "No nombre"
                let email = dataResult?.user.email ?? "No email"
                print("acceso correcto por Facebook, id: \(id), nombre \(nombre), email: \(email)")
                
                self.Usuario.id = id
                self.Usuario.nombre = nombre
                self.Usuario.correo = email
                print("acceso correcto por Facebook, id: \(self.Usuario.id), nombre \(self.Usuario.nombre), email: \(self.Usuario.correo)")
                success(true)
            }
            
        }
    }
    
    //GUARDA EN BASE DE DATOS
    func AgregarUsuario(nombre: String, correo: String, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        let db = Firestore.firestore() //crea conexion
        
        let campos : [String:Any] = ["nombre": nombre, "correo": correo, "foto": "gs://fir-crud-af577.appspot.com/imagenes/perfil-de-usuario.png"]
        db.collection("Usuarios").document(self.Usuario.id).setData(campos){error in
            if let error = error{
                failure(error)
            }else{
                print("guardo")
                success(true)
            }
        }
        
    }
    
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
                        let idHabitacion = habitacion.id
                        let nombre = valor["nombre"] as? String ?? "Sin nombre"
                        guard let time = valor["proxRecordatorio"] as? Timestamp else {
                            return 
                        }
                        let proxRecordatorio = time.dateValue()
                        let tipo = "Riego"
                        let dias = valor["riegoNum"]as? Int ?? 3
                        let riegoPeriod = valor["riegoPeriod"] as? String ?? "Dias"
                        let registros = RecordatorioModel(id: id, idHabitacion: idHabitacion, planta: nombre, tipo: tipo, fecha: proxRecordatorio, dias: dias, periodo: riegoPeriod)
                        recordatoriosShow.append(registros)
                    }
                    success(recordatoriosShow)
                }
            }
            

        }
    }
    func existeId(success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        let db = Firestore.firestore() //crea conexion
        let coleccion = db.collection("Usuarios")
        coleccion.document(self.Usuario.id).getDocument{(document, error) in
            if let error = error{
                failure(error)
            }else{
                if let document = document, document.exists {
                    // El documento existe
                    // Acceder a los datos del documento con la variable datos
                    let datos = document.data()
                    self.Usuario.nombre = datos?["nombre"] as? String ?? "Sin nombre"
                    self.Usuario.foto = datos?["foto"] as? String ?? "Recamara"
                    self.Usuario.correo = datos?["correo"] as? String ?? "nadie.com"
                    success(true)
                } else {
                    // El documento no existe
                    print("El usuario no existe en Usuarios")
                    success(false)
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
    func actualizaRecordatorio(idHabitacion : String, idPlanta : String, fechaNueva: Date, success : @escaping(_ done : Bool) ->(), failure: @escaping (_ error: Error) -> ()){
        
        let db = Firestore.firestore()
        let campos : [String:Any] = ["proxRecordatorio":fechaNueva]
        db.collection("Usuarios").document(self.Usuario.id).collection("Habitacion").document(idHabitacion).collection("Plantas").document(idPlanta).updateData(campos){error in
            if let error = error{
                failure(error)
            }else{
                success(true)
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
