//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by juansev on 26/05/25.
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
    @State private var selectedCharacter: Character?
    
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
            id: 2,
            name: "Morty Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: "Male",
            origin: OriginInCharacter(name: "Earth (C-137)", url: URL(string: "https://rickandmortyapi.com/api/location/1")!),
            location: LocationInCharacter(name: "Earth (Replacement Dimension)", url: URL(string: "https://rickandmortyapi.com/api/location/20")!),
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!,
            episode: [
                URL(string: "https://rickandmortyapi.com/api/episode/1")!,
                URL(string: "https://rickandmortyapi.com/api/episode/2")!,
            ],
            url: URL(string: "https://rickandmortyapi.com/api/character/2")!
        )
    ]
    
    @State var search = ""
    @State private var isSearching = false
    
    var filteredCharacters: [Character] {
        if search.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.localizedCaseInsensitiveContains(search) }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background with Rick and Morty vibes
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.1, blue: 0.2),
                        Color(red: 0.1, green: 0.15, blue: 0.25),
                        Color(red: 0.15, green: 0.2, blue: 0.3)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Floating particles effect
                ParticleBackground()
                
                VStack(spacing: 0) {
                    if filteredCharacters.isEmpty && !search.isEmpty {
                        EmptyStateView(searchText: search)
                    } else if characters.isEmpty {
                        EmptyStateView()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(filteredCharacters) { character in
                                    CharacterListItemView(character: character)
                                        .onTapGesture {
                                            selectedCharacter = character
                                        }
                                        .contextMenu {
                                            Button {
                                            } label: {
                                                Label("Add to Favorites", systemImage: "star")
                                            }
                                            
                                            Button {
                                            } label: {
                                                Label("Share", systemImage: "square.and.arrow.up")
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .if(isSearching) { view in
                view.searchable(text: $search, prompt: "Search characters...")
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                                    Text("Rick and Morty")
                                        .font(.largeTitle.bold())
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [Color.green, Color.cyan],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isSearching.toggle()
                            if !isSearching {
                                search = ""
                            }
                        }
                    } label: {
                        Image(systemName: isSearching ? "xmark.circle.fill" : "magnifyingglass")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.green, Color.cyan],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                }
            }
            .sheet(item: $selectedCharacter) { character in
                CharacterDetailView(character: character)
            }
        }
    }
}

struct CharacterListItemView: View {
    let character: Character
    
    var statusColor: Color {
        switch character.status {
        case .alive: return .green
        case .dead: return .red
        case .unknown: return .orange
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Character image with portal effect
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                statusColor.opacity(0.3),
                                Color.cyan.opacity(0.2),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 25,
                            endRadius: 50
                        )
                    )
                    .frame(width: 100, height: 100)
                    .blur(radius: 1)
                
                AsyncImage(url: character.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: [statusColor, Color.cyan],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                        )
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        )
                }
            }
            
            // Character info
            VStack(alignment: .leading, spacing: 8) {
                Text(character.name)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                // Status and species
                HStack(spacing: 6) {
                    Circle()
                        .fill(statusColor)
                        .frame(width: 8, height: 8)
                    
                    Text("\(character.status.rawValue.capitalized) • \(character.species)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                // Origin with icon
                HStack(spacing: 6) {
                    Image(systemName: "globe.americas")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.cyan)
                    
                    Text(character.origin.name)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(1)
                }
                
                // Episodes count
                HStack(spacing: 6) {
                    Image(systemName: "tv")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.green)
                    
                    Text("\(character.episode.count) episodes")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            Spacer()
            
            // Chevron with portal glow
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.cyan)
                .padding(.trailing, 4)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.black.opacity(0.4),
                            Color.black.opacity(0.6)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.green.opacity(0.3),
                                    Color.cyan.opacity(0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .shadow(
            color: statusColor.opacity(0.2),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

struct EmptyStateView: View {
    let searchText: String?
    
    init(searchText: String? = nil) {
        self.searchText = searchText
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Portal animation
            ZStack {
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [Color.green, Color.cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 4
                    )
                    .frame(width: 120, height: 120)
                
                Image(systemName: searchText != nil ? "magnifyingglass" : "person.3")
                    .font(.system(size: 40, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.green, Color.cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            
            VStack(spacing: 8) {
                Text(searchText != nil ? "No Results" : "No Characters")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(searchText != nil ?
                     "No characters found for '\(searchText!)'" :
                     "No character data available")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}

struct ParticleBackground: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<15, id: \.self) { i in
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.green.opacity(0.3), Color.cyan.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: CGFloat.random(in: 2...6))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: animate ?
                            CGFloat.random(in: 0...UIScreen.main.bounds.height) :
                            CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
                    .animation(
                        Animation.linear(duration: Double.random(in: 10...20))
                            .repeatForever(autoreverses: false)
                            .delay(Double.random(in: 0...5)),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    CharactersListView()
}
