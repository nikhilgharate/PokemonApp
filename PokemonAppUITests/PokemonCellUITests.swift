//
//  PokemonCellUITests.swift
//  PokemonAppUITests
//
//  Created by iAURO on 02/08/24.
//
//
//import SwiftUI
//import XCTest
//@testable import PokemonApp
//import Kingfisher
//
//// Mock data for testing
//struct MockData {
//    static let mockPokemon = Pokemon(id: 1, name: "Pikachu", imageUrl: "https://example.com/pikachu.png", type: "electric", description: "Pikachu is an Electric-type Pokémon.", height: 4, weight: 60)
//}
//
//final class PokemonCellUITests: XCTestCase {
//    
//    var viewModel: PokemonviewModel!
//        var pokemonCell: PokemonCell!
//        var hostingController: UIHostingController<PokemonCell>!
//    
//
//    override func setUp() {
//        super.setUp()
//                viewModel = PokemonviewModel()
//                pokemonCell = PokemonCell(pokemon: MockData.mockPokemon, viewModel: viewModel)
//                hostingController = UIHostingController(rootView: pokemonCell)
//      
//    }
//
//    override func tearDown()  {
//        viewModel = nil
//               pokemonCell = nil
//               hostingController = nil
//               super.tearDown()
//    }
//    
//    func testBackgroundColor() {
//           let expectedColor = Color(viewModel.backgroundColor(forType: MockData.mockPokemon.type))
//           XCTAssertEqual(pokemonCell.backgroundColor, expectedColor)
//       }
//
////    // Test the initialization and basic properties of the view
////        func testPokemonCellInitialization() {
////            XCTAssertEqual(pokemonCell.pokemon.id, MockData.mockPokemon.id)
////            XCTAssertEqual(pokemonCell.pokemon.name, MockData.mockPokemon.name)
////            XCTAssertEqual(pokemonCell.pokemon.type, MockData.mockPokemon.type)
////        }
//
//    }
//
