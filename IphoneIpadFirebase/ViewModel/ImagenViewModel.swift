//
//  ImagenViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 18/01/23.
//

import Foundation
import FirebaseStorage

class ImagenViewModel : ObservableObject{
    @Published var data : Data? = nil
    
    init(imagenUrl: String) {
        let storageImage = Storage.storage().reference(forURL: imagenUrl)
        storageImage.getData(maxSize: 1*1024*1024){ (data, error) in
            if let error = error?.localizedDescription{
                print("error al traer la imagen", error)
            }else{
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }
    }
}
