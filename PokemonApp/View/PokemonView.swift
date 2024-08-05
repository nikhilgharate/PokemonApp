//
//  PokemonView.swift
//  PokemonApp
//
//  Created by iAURO on 29/07/24.

import SwiftUI

// View for displaying the list of Pokémon
struct PokemonView: View {
    // Define the grid layout with two flexible columns
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    // State variable to manage the loading state
    @State private var isLoading = true
    
    // ObservedObject for the view model
    @ObservedObject var viewModel = PokemonviewModel()
    
    var body: some View {
        Group {
            // Show loading indicator if data is loading
            if isLoading {
                ProgressView("Loading Pokemon...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        // Fetch Pokémon data and update loading state
                        viewModel.fetchPokemon { success in
                            isLoading = !success
                        }
                    }
            } else {
                // Show grid of Pokémon once data is loaded
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.pokemon) { pokemon in
                            NavigationLink(
                                destination: PokemonDetail(pokemon: pokemon),
                                label: {
                                    PokemonCell(pokemon: pokemon, viewModel: viewModel)
                                })
                            .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .navigationTitle("Pokemon")
    }
}

// Back button component
struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
                .padding(.all, 12)
                .background(Color.white)
                .cornerRadius(8.0)
        }
    }
}

// Preview provider for the PokemonView
struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
