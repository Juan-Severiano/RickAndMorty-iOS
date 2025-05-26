//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by iredefbmac_21 on 26/05/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CharacterDetailView(
        character: Character(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            type: "",
            gender: "Male",
            origin: OriginInCharacter(name: "Earth (C-137)", url: URL(string: "https://rickandmortyapi.com/api/location/1")!),
            location: LocationInCharacter(name: "Citadel of Ricks", url: URL(string: "https://rickandmortyapi.com/api/location/3")!),
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
            episode: [
                URL(string: "https://rickandmortyapi.com/api/episode/1")!,
                URL(string: "https://rickandmortyapi.com/api/episode/2")!,
            ],
            url: URL(string: "https://rickandmortyapi.com/api/character/1")!
        )
    )
}
