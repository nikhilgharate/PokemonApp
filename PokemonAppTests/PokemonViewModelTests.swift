//
//  PokemonViewModelTests.swift
//  PokemonAppTests
//
//  Created by iAURO on 31/07/24.
//
//
//import XCTest
//
//final class PokemonViewModelTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}
import XCTest
@testable import PokemonApp

class PokemonviewModelTests: XCTestCase {
    
    private var session: URLSession!
    
    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
    }
    
    func testFetchPokemonSuccess() {
        let viewModel = PokemonviewModel(session: session)
        let expectation = XCTestExpectation(description: "Fetch Pokémon")
        
        let mockData = """
        [
            {
                "id": 1,
                "name": "Bulbasaur",
                "imageUrl": "https://example.com/bulbasaur.png",
                "type": "poison",
                "description": "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.",
                "height": 70,
                "weight": 69
            }
        ]
        """.data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockData)
        }
        
        viewModel.fetchPokemon { success in
            XCTAssertTrue(success)
            XCTAssertEqual(viewModel.pokemon.count, 1)
            XCTAssertEqual(viewModel.pokemon.first?.name, "Bulbasaur")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchPokemonFailure() {
        let viewModel = PokemonviewModel(session: session)
        let expectation = XCTestExpectation(description: "Fetch Pokémon")
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        viewModel.fetchPokemon { success in
            XCTAssertFalse(success)
            XCTAssertTrue(viewModel.pokemon.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testBackgroundColorForType() {
        let viewModel = PokemonviewModel()
        
        XCTAssertEqual(viewModel.backgroundColor(forType: "fire"), .systemRed)
        XCTAssertEqual(viewModel.backgroundColor(forType: "poison"), .systemGreen)
        XCTAssertEqual(viewModel.backgroundColor(forType: "water"), .systemBlue)
        XCTAssertEqual(viewModel.backgroundColor(forType: "electric"), .systemYellow)
        XCTAssertEqual(viewModel.backgroundColor(forType: "psychic"), .systemPurple)
        XCTAssertEqual(viewModel.backgroundColor(forType: "normal"), .systemOrange)
        XCTAssertEqual(viewModel.backgroundColor(forType: "ground"), .systemGray)
        XCTAssertEqual(viewModel.backgroundColor(forType: "flying"), .systemTeal)
        XCTAssertEqual(viewModel.backgroundColor(forType: "fairy"), .systemPink)
        XCTAssertEqual(viewModel.backgroundColor(forType: "unknown"), .systemIndigo)
    }
}
