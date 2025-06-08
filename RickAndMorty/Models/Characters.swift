//
//  Characters.swift
//  RickAndMorty
//
//  Created by juansev on 26/05/25.
//

import Foundation

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

struct OriginInCharacter: Codable {
    let name: String
    let url: URL
}

struct LocationInCharacter: Codable {
    let name: String
    let url: URL
}
struct Location: Identifiable, Codable {
    let id: Int
    let name: String
    let url: URL
    let type: String
    let dimension: String
    let residents: [URL]
}

struct Origin: Identifiable, Codable {
    let id: Int
    let name: String
    let url: URL
}

struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Identifiable, Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    
    let gender: String
    let origin: OriginInCharacter
    let location: LocationInCharacter
    let image: URL
    let episode: [URL]
    let url: URL
}
