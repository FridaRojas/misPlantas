//
//  HabitacionModel.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 18/01/23.
//

import Foundation

struct HabitacionModel : Identifiable {
    var id : String
    var nombre: String
    var tipo : String
    var plantas = [PlantasModel]()
}




