//
//  PlantNetViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 31/01/23.
//

import Foundation
import Alamofire
import FirebaseStorage

final class PlantNetViewModel{
    
    static let shared = PlantNetViewModel()
    private let urlPlant = "https://my-api.plantnet.org/v2/identify/all?"
    private let apiKey = "2b101bEfDp05o64ejq5jB8ZU8O"
    private let statusOk = 200...299
    
    //request en PlantNet
    func getPlanta(imagen: String, success : @escaping(_ resultado: [Result]) ->(), failure: @escaping (_ error: Error) -> ()) {
        
        //hace la url
        let url = "\(urlPlant)images=\(imagen)&organs=auto&include-related-images=true&no-reject=false&lang=es&api-key=\(apiKey)"
        
        AF.request(url, method: .get).validate(statusCode: statusOk).responseDecodable (of: PlantNet.self) { respuesta in
            if let info = respuesta.value?.results{
                success(info)
            }else{
                failure(respuesta.error!)
            }
        }
        
    }
    
    func obtieneLinkFoto(foto: Data, success : @escaping(_ resultado: [Result]) ->(), failure: @escaping (_ error: Error) -> ()) {
        var urlFoto = ["",""] //[0] para url http, [1] para url de storage, para eliminarla después
        let fotoError = "https://firebasestorage.googleapis.com/v0/b/fir-crud-af577.appspot.com/o/imagenes%2Ferror.png?alt=media&token=b74ee57e-c4fa-453d-ae4d-b13af6fe73f3"
        let storage = Storage.storage().reference()
        let nombreImagen = UUID()
        let directorio = storage.child("imagenes/\(nombreImagen)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        directorio.putData(foto, metadata: metadata){data, error in
            if error == nil{
                //Ya que guardo imagen, guarda url
                urlFoto[1] =  String(describing: directorio) //nombre para poder eliminarla
                directorio.downloadURL{(url, error) -> Void in
                    if error != nil{
                        // si tuvo error, manda el error
                        failure(error!)
                    }else{
                        //guarda como string la url y la codifica
                        urlFoto[0] = url?.absoluteString ?? fotoError
                        urlFoto[0] = urlFoto[0].addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? fotoError
                        //llama a la funcion que consume el API y manda resultados
                        self.getPlanta(imagen: urlFoto[0]){ resultados in
                            //elimina la imagen del storage
                            let borrarImagen = Storage.storage().reference(forURL: urlFoto[1])
                            borrarImagen.delete(completion: nil)
                            success(resultados)
                        } failure: { error in
                            failure(error)
                            print("error:",error)
                        }
                    }
                }
                //elimina la imagen del storage
                //let borrarImagen = Storage.storage().reference(forURL: urlFoto[1])
                //borrarImagen.delete(completion: nil)
            }else{
                if let error = error{
                    print("fallo al subir en storage", error)
                    failure(error)
                }
            }
        }
    }
    
}
