//
//  FavoritesView.swift
//  PokemonApp
//
//  Created by iAURO on 05/08/24.


import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: PokemonviewModel
    
    private let columns = [GridItem(.flexible(), spacing: 25), GridItem(.flexible(), spacing: 25)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                spacing: 16
            ) {
                ForEach(viewModel.favoritePokemon) { pokemon in
                    NavigationLink(
                        destination: PokemonDetail(pokemon: pokemon),
                        label: {
                            PokemonCell(pokemon: pokemon, viewModel: viewModel)
                                .frame(maxWidth: .infinity)
                        }
                    )
                    .foregroundColor(.black)
                }
            }
            .padding()
        }
        .navigationTitle("Favorite Pokemon")
    }
}

// Preview provider for the FavoritesView
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: PokemonviewModel())
    }
}
