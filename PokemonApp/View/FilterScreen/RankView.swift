//
//  RankView.swift
//  PokemonApp
//
//  Created by iAURO on 05/08/24.
import SwiftUI

struct RankView: View {
    @ObservedObject var viewModel = PokemonviewModel()
    
    private let columns = [GridItem(.flexible(), spacing: 25), GridItem(.flexible(), spacing: 25)]
    
    var body: some View {
        NavigationView {
            VStack {
                // Filter input fields
                TextField("Min Attack", text: $viewModel.minAttack)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal) // Add horizontal padding

                TextField("Min Defense", text: $viewModel.minDefense)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal) // Add horizontal padding
                
                // Apply Filter Button
                Button(action: {
                    viewModel.applyFilters() // Apply the filters when the button is tapped
                }) {
                    Text("Apply Filter")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top) // Add spacing above the button
                
                // Display the filtered Pokémon
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        spacing: 16 // Adjust the spacing between cards here
                    ) {
                        ForEach(viewModel.filteredPokemon) { pokemon in
                            NavigationLink(
                                destination: PokemonDetail(pokemon: pokemon),
                                label: {
                                    PokemonCell(pokemon: pokemon, viewModel: viewModel)
                                        .frame(maxWidth: .infinity) // Ensure cells use full width
                                }
                            )
                            .foregroundColor(.black)
                        }
                    }
                    .padding() // Add padding around the grid
                }
            }
            .navigationTitle("Ranked Pokemon")
        }
    }
}

// Preview provider for the RankView
struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
    }
}
