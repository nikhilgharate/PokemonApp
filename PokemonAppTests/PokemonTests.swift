//
//  PokemonModelTests.swift
//  PokemonAppTests
//
//  Created by iAURO on 31/07/24.
//
import XCTest
@testable import PokemonApp

class PokemonTests: XCTestCase {

    // Sample JSON for testing
    let validPokemonJSON = """
    {
        "id": 1,
        "name": "Bulbasaur",
        "imageUrl": "https://example.com/bulbasaur.png",
        "type": "poison",
        "description": "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.",
        "height": 70,
        "weight": 69
    }
    """.data(using: .utf8)!
    
    let invalidPokemonJSON = """
    {
        "id": "one",
        "name": "Bulbasaur",
        "imageUrl": "https://example.com/bulbasaur.png",
        "type": "poison",
        "description": "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.",
        "height": 70,
        "weight": 69
    }
    """.data(using: .utf8)!

    // Test for successful decoding of valid JSON
    func testDecodingValidPokemonJSON() throws {
        // Attempt to decode the sample JSON
        let pokemon = try JSONDecoder().decode(Pokemon.self, from: validPokemonJSON)
        
        // Assert that the properties are correctly decoded
        XCTAssertEqual(pokemon.id, 1)
        XCTAssertEqual(pokemon.name, "Bulbasaur")
        XCTAssertEqual(pokemon.imageUrl, "https://example.com/bulbasaur.png")
        XCTAssertEqual(pokemon.type, "poison")
        XCTAssertEqual(pokemon.description, "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.")
        XCTAssertEqual(pokemon.height, 70)
        XCTAssertEqual(pokemon.weight, 69)
    }

    // Test for failing decoding of invalid JSON
    func testDecodingInvalidPokemonJSON() {
        // Assert that decoding invalid JSON throws a typeMismatch error
        XCTAssertThrowsError(try JSONDecoder().decode(Pokemon.self, from: invalidPokemonJSON)) { error in
            guard case DecodingError.typeMismatch = error else {
                XCTFail("Expected type mismatch error, but got \(error)")
                return
            }
        }
    }
}
