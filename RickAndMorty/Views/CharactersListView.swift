//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by iredefbmac_21 on 26/05/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct CharactersListView: View {
    let characters: [Character] = [
        Character(
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
        ),
        Character(
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
    ]
    
    @State var search = ""
    
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack {
                if characters.isEmpty {
                    Text("No data found")
                } else {
                    List {
                        ForEach(characters) { character in
                            CharacterListItemView(character: character)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "star")
                                    }
                                    .tint(.main)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "square.and.arrow.up")
                                    }
                                    .tint(.mainInverse)
                                }
                        }
                    }
                    .listStyle(.inset)
                }
            }
            .navigationTitle("Rick and Morty")
            .if(isSearching) {
                view in view.searchable(text: $search)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isSearching.toggle()
                    } label: {
                        Image(systemName: isSearching ? "xmark" : "magnifyingglass")
                            .foregroundColor(.main)
                    }
                }
            }
        }
    }
}

#Preview {
    CharactersListView()
}
