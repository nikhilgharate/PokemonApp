
//  PokemonCell.swift
//  PokemonApp

//  Created by iAURO on 29/07/24.



//import SwiftUI
//import Kingfisher
//
//// View for displaying individual Pokémon cells
//struct PokemonCell: View {
//    
//    // Properties for Pokémon data and ViewModel
//    let pokemon: Pokemon
//    @ObservedObject var viewModel = PokemonviewModel()
//    let backgroundColor: Color
//    
//    // Initializer to set up the Pokémon and ViewModel
//    init(pokemon: Pokemon, viewModel: PokemonviewModel) {
//        self.pokemon = pokemon
//        self.viewModel = viewModel
//        self.backgroundColor = Color(viewModel.backgroundColor(forType: pokemon.type))
//    }
//    
//    // Body of the view
//       var body: some View {
//           ZStack {
//               
//               VStack(alignment: .leading) {
//                   // Display Pokémon name
//                   Text("\(pokemon.id). \(pokemon.name.uppercased())")
//                       .font(.headline)
//                       .foregroundColor(.white)
//                       .padding(.top, 8)
//                       .padding(.leading)
//                   
//                   HStack {
//                       // Display Pokémon type
//                       Text(pokemon.type)
//                           .font(.subheadline).bold()
//                           .foregroundColor(.white)
//                           .padding(.horizontal, 16)
//                           .padding(.vertical, 8)
//                           .overlay(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.25)))
//                           .frame(width: 100, height: 24)
//                       
//                       // Load and display Pokémon image using Kingfisher
//                       KFImage(URL(string: pokemon.imageUrl))
//                           .resizable()
//                           .scaledToFit()
//                           .padding(.bottom, 8)
//                           .padding(.trailing, 8)
//                           .frame(width: 80, height: 90)
//                   }
//                   
//                   // Display Pokémon attack and defense
//                   HStack {
//                       Text("Attack: \(pokemon.attack)")
//                           .font(.subheadline)
//                           .foregroundColor(.white)
//                           .padding(.leading, 16)
//                       
//                       Text("Def: \(pokemon.defense)")
//                           .font(.subheadline)
//                           .foregroundColor(.white)
//                           .padding(.leading, 16)
//                   }
//                   .padding(.top, 4)
//                   .padding(.bottom, 8)
//               }
//           }
//           // Set background color based on Pokémon type
//           .background(Color(viewModel.backgroundColor(forType: pokemon.type)))
//           .cornerRadius(10)
//           .shadow(color: Color(viewModel.backgroundColor(forType: pokemon.type)), radius: 30, x: 0.0, y: 0.0)
//       }
//   }
//    
//    // Body of the view
////    var body: some View {
////        ZStack {
////            VStack(alignment: .leading) {
////                // Display Pokémon name
////                Text("\(pokemon.id). \(pokemon.name.uppercased())")
////                    .font(.headline)
////                    .foregroundColor(.white)
////                    .padding(.top, 8)
////                    .padding(.leading)
////                
////                HStack {
////                    // Display Pokémon type
////                    Text(pokemon.type)
////                        .font(.subheadline).bold()
////                        .foregroundColor(.white)
////                        .padding(.horizontal, 16)
////                        .padding(.vertical, 8)
////                        .overlay(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.25)))
////                        .frame(width: 100, height: 24)
////                    
////                    // Load and display Pokémon image using Kingfisher
////                    KFImage(URL(string: pokemon.imageUrl))
////                        .resizable()
////                        .scaledToFit()
////                        .padding(.bottom, 8)
////                        .padding(.trailing, 8)
////                        .frame(width: 80, height: 90)
////                }
////            }
////        }
////        // Set background color based on Pokémon type
////        .background(Color(viewModel.backgroundColor(forType: pokemon.type)))
////        .cornerRadius(10)
////        .shadow(color: Color(viewModel.backgroundColor(forType: pokemon.type)), radius: 30, x: 0.0, y: 0.0)
////    }
////}
//
//// Uncomment the following code for previewing the PokemonCell in Xcode's canvas
//// struct PokemonCell_Previews: PreviewProvider {
////     static var previews: some View {
////         Group {
////             PokemonCell(pokemon: MOCK_POKEMON[1], viewModel: PokemonviewModel())
////         }.previewLayout(.fixed(width: 200, height: 200))
////     }
//// }

import SwiftUI
import Kingfisher

struct PokemonCell: View {
    let pokemon: Pokemon
    @ObservedObject var viewModel: PokemonviewModel
    
    let backgroundColor: Color
    
    init(pokemon: Pokemon, viewModel: PokemonviewModel) {
        self.pokemon = pokemon
        self.viewModel = viewModel
        self.backgroundColor = Color(viewModel.backgroundColor(forType: pokemon.type))
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("\(pokemon.id). \(pokemon.name.uppercased())")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .padding(.leading)
                
                HStack {
                    Text(pokemon.type)
                        .font(.subheadline).bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.25)))
                        .frame(width: 100, height: 24)
                    
                    KFImage(URL(string: pokemon.imageUrl))
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 8)
                        .padding(.trailing, 8)
                        .frame(width: 80, height: 90)
                }
                
                HStack {
                    Text("Attack: \(pokemon.attack)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.leading, 16)
                    
                    Text("Def: \(pokemon.defense)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleFavorite(pokemonID: pokemon.id)
                    }) {
                        Image(systemName: viewModel.favoritePokemonIDs.contains(pokemon.id) ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.favoritePokemonIDs.contains(pokemon.id) ? .black : .white)
                            .padding()
                    }
                }
                .padding(.top, 4)
                .padding(.bottom, 8)
            }
        }
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(color: backgroundColor, radius: 30, x: 0.0, y: 0.0)
    }
}
