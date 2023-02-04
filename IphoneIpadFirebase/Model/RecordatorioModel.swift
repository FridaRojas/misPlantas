//
//  Tareas.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 13/01/23.
//

import SwiftUI

//para arreglo de tareas
struct RecordatorioModel: Identifiable{
    var id : String
    var planta : String
    var tipo : String
    var fecha : Date 
}
// todas las tareas
/*struct TareasMetaData : Identifiable{
    var id = UUID().uuidString
    var tareas : [Tarea]
    var fecha : Date
}

//
func obtieneFecha(offset: Int)->Date{
    let calendario = Calendar.current
    let date = calendario.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

var tareas : [TareasMetaData] = [
    TareasMetaData(tareas: [
        Tarea(planta: "Cactus Mounstro", tipo: "Riego"),
        Tarea(planta: "Monstera Deliciosa", tipo: "Riego"),
        Tarea(planta: "Helecho", tipo: "Abono")], fecha: obtieneFecha(offset: 1)),
    TareasMetaData(tareas: [
        Tarea(planta: "Patitas de Oso", tipo: "Riego"),
        Tarea(planta: "Croton", tipo: "Riego")], fecha: obtieneFecha(offset: -3)),
    TareasMetaData(tareas: [
        Tarea(planta: "Poto", tipo: "Abono")], fecha: obtieneFecha(offset: -8))
]*/


