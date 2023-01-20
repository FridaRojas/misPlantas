//
//  ImagenFirebase.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 18/01/23.
//

import SwiftUI

struct ImagenFirebase: View {
    let imagenAlternativa = UIImage(systemName: "photo")
    @ObservedObject var imagenCarga : ImagenViewModel
    
    init(imagenUrl: String) {
        imagenCarga = ImagenViewModel(imagenUrl: imagenUrl)
    }
    
    var imagen : UIImage? {
        imagenCarga.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: imagen ?? imagenAlternativa!).resizable()
        let _ = print("ImagenFirebase")
    }
}
