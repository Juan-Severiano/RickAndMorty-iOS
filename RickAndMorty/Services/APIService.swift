//
//  APIService.swift
//  RickAndMorty
//
//  Created by juansev on 26/05/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
    
    private init() {}
    
    public func getAllCharacters() async throws -> [CharacterResponse] {
        guard let url = URL(string: "\(baseURL)/character/?page=1") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([CharacterResponse].self, from: data)
        
    }
}
