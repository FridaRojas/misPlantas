//
//  PlantNetViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 31/01/23.
//

import Foundation
import Alamofire

final class PlantNetViewModel{
    static let shared = PlantNetViewModel()
    private let urlPlant = "https://my-api.plantnet.org/v2/identify/all?"
    private let apiKey = "2b101bEfDp05o64ejq5jB8ZU8O"
    private let statusOk = 200...299
    
    func getPlanta(imagen: String, success : @escaping(_ resultado: [Result]) ->(), failure: @escaping (_ error: Error) -> ()) {
        
        let url = "\(urlPlant)images=\(imagen)&organs=auto&include-related-images=true&no-reject=false&lang=es&api-key=\(apiKey)"
        
        AF.request(url, method: .get).validate(statusCode: statusOk).responseDecodable (of: PlantNet.self) { respuesta in
            if let info = respuesta.value?.results{
                print("resultadoooooooooooooooooooooooo: ",info)
                success(info)
            }else{
                print("ERRRRRRRRRRROOOOOOOOOOOOOOOOORRRRRRRRRRRR", respuesta.error)
                failure(respuesta.error!)
            }
        }
        
    }
    /*func getPlanta(imagen: String) {
        
        let url = "\(urlPlant)images=\(imagen)&organs=auto&include-related-images=true&no-reject=false&lang=es&api-key=\(apiKey)"
        
        AF.request(url, method: .get).validate(statusCode: statusOk).responseDecodable (of: PlantNet.self) { respuesta in
            if let info = respuesta.value?.results{
                print("resultadooooooooooooooooooooooooooooooooooooooo: ",info)
                
            }else{
                print("Erroooooooooooooooooooooooooooooooooooooooooor")
            }
        }
        
    }*/
    
}
