//
//  PokemonViewTests.swift
//  PokemonAppUITests
//
//  Created by iAURO on 31/07/24.
//
//
//import XCTest
//
//final class PokemonViewTests: XCTestCase {
//    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//        
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//    
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//        
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//}
import SwiftUI
import XCTest
import Kingfisher

// Mock Pokemon and ViewModel for testing
struct MockPokemon: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var imageUrl: String
}


// Unit tests for the PokemonCell
class PokemonCellTests: XCTestCase {
    
   

    override func setUp() {
        super.setUp()
    }

    func testPokemonCellInitialization() {
        let pokemon = MockPokemon(name: "Pikachu", type: "Electric", imageUrl: "https://example.com/pikachu.png")
     
    }

    func testPokemonCellBackgroundColorForFireType() {
        let pokemon = MockPokemon(name: "Charmander", type: "Fire", imageUrl: "https://example.com/charmander.png")
        
       
    }

    func testPokemonCellBackgroundColorForWaterType() {
        let pokemon = MockPokemon(name: "Squirtle", type: "Water", imageUrl: "https://example.com/squirtle.png")
        
     
    }

    override func tearDown() {
        super.tearDown()
    }
}
