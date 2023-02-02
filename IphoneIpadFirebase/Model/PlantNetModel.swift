//
//  PlantNetModel.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 31/01/23.
//

import Foundation

// MARK: - Welcome
struct PlantNet: Decodable {
    let query: Query
    let results: [Result]
}

struct Query: Decodable {
    let project: String
    let images: [String]
    let organs: [String]
    let includeRelatedImages: Bool
}

struct Result: Decodable {
    let species: Species
    let images: [Imagen]
}

struct Imagen: Decodable {
    let url: URLClass
}

struct URLClass: Decodable {
    let o : String
    let m : String
    let s : String
}

struct Species: Decodable {
    let commonNames: [String]
}

