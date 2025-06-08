//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by juansev on 26/05/25.
//
import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header com imagem e informações básicas
                headerSection
                
                // Informações detalhadas
                detailsSection
                
                // Episódios
                episodesSection
                
                Spacer(minLength: 20)
            }
        }
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.2, blue: 0.3),
                    Color(red: 0.05, green: 0.15, blue: 0.25)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                        Text("Back")
                            .font(.system(size: 17))
                    }
                    .foregroundColor(.green)
                }
            }
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            // Imagem do personagem com portal effect
            ZStack {
                // Portal background effect
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.green.opacity(0.3),
                                Color.blue.opacity(0.2),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 60,
                            endRadius: 120
                        )
                    )
                    .frame(width: 240, height: 240)
                    .blur(radius: 2)
                
                AsyncImage(url: character.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                        )
                }
                .frame(width: 160, height: 160)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color.green, Color.blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 4
                        )
                )
                .shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            
            // Nome e status
            VStack(spacing: 8) {
                Text(character.name)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                StatusBadge(status: character.status)
            }
        }
        .padding(.top, 20)
        .padding(.horizontal)
    }
    
    private var detailsSection: some View {
        VStack(spacing: 16) {
            // Informações básicas
            VStack(spacing: 12) {
                InfoRow(title: "Species", value: character.species, icon: "dna")
                
                if !character.type.isEmpty {
                    InfoRow(title: "Type", value: character.type, icon: "text.badge.star")
                }
                
                InfoRow(title: "Gender", value: character.gender, icon: "person.2")
                InfoRow(title: "Origin", value: character.origin.name, icon: "globe")
                InfoRow(title: "Location", value: character.location.name, icon: "location")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.green.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .padding(.horizontal)
        .padding(.top, 32)
    }
    
    private var episodesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "tv")
                    .foregroundColor(.green)
                    .font(.system(size: 18, weight: .medium))
                
                Text("Episodes")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(character.episode.count)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.green)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.green.opacity(0.2))
                    )
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 4), spacing: 8) {
                ForEach(Array(character.episode.enumerated()), id: \.offset) { index, url in
                    EpisodeChip(episodeNumber: index + 1)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.3))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                )
        )
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

struct StatusBadge: View {
    let status: Status
    
    var statusColor: Color {
        switch status {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .orange
        }
    }
    
    var statusText: String {
        switch status {
        case .alive:
            return "ALIVE"
        case .dead:
            return "DEAD"
        case .unknown:
            return "UNKNOWN"
        }
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
            
            Text(statusText)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(statusColor)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(statusColor.opacity(0.15))
                .overlay(
                    Capsule()
                        .stroke(statusColor.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.green)
                .font(.system(size: 16, weight: .medium))
                .frame(width: 20)
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
                .frame(maxWidth: 80, alignment: .leading)
            
            Text(value)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct EpisodeChip: View {
    let episodeNumber: Int
    
    var body: some View {
        Text("E\(episodeNumber)")
            .font(.system(size: 12, weight: .bold))
            .foregroundColor(.white)
            .frame(width: 40, height: 32)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(0.6),
                                Color.green.opacity(0.6)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
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
                    URL(string: "https://rickandmortyapi.com/api/episode/3")!,
                    URL(string: "https://rickandmortyapi.com/api/episode/4")!,
                    URL(string: "https://rickandmortyapi.com/api/episode/5")!,
                    URL(string: "https://rickandmortyapi.com/api/episode/6")!,
                ],
                url: URL(string: "https://rickandmortyapi.com/api/character/1")!
            )
        )
    }
}
