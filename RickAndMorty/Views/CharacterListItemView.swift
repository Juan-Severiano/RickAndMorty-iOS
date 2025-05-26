//
//  CharacterListItemView.swift
//  RickAndMorty
//
//  Created by iredefbmac_21 on 26/05/25.
//

import SwiftUI

struct CharacterListItemView: View {
    @State var character: Character
    
    // var roundedColor: Color = character.status == .alive ? .green : .red
    
    var body: some View {
        HStack() {
            AsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(character.status == .alive ? .green : .red, lineWidth: 3))
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(character.status == .alive ? .green : .red)
                    Text("\(character.species) - \(character.status.rawValue)")
                    .font(.callout)                    }
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.red)
                    
                    Text(character.origin.name)
                        .font(.callout)
                }
                
            }
            Spacer()
        }
    }
}

#Preview {
    CharacterListItemView(
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
