//
//  MockURLProtocolTests.swift
//  PokemonAppTests
//
//  Created by iAURO on 31/07/24.
//
import XCTest
@testable import PokemonApp

final class MockURLProtocolTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Reset the request handler before each test
        MockURLProtocol.requestHandler = nil
    }

    func testMockURLProtocolReturnsExpectedResponse() {
        // Define the expected response and data
        let expectedData = "test data".data(using: .utf8)!
        let expectedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        // Set up the request handler
        MockURLProtocol.requestHandler = { request in
            return (expectedResponse, expectedData)
        }

        // Create the URL session configuration and assign the mock protocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        // Perform the request
        let expectation = XCTestExpectation(description: "Request should succeed")

        let url = URL(string: "https://example.com")!
        let task = session.dataTask(with: url) { data, response, error in
            // Verify that there was no error
            XCTAssertNil(error)

            // Verify the response
            XCTAssertEqual((response as! HTTPURLResponse).statusCode, 200)

            // Verify the data
            XCTAssertEqual(data, expectedData)

            expectation.fulfill()
        }
        task.resume()

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }

    func testMockURLProtocolHandlesNoRequestHandler() {
        // Create the URL session configuration and assign the mock protocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        // Perform the request
        let expectation = XCTestExpectation(description: "Request should fail")

        let url = URL(string: "https://example.com")!
        let task = session.dataTask(with: url) { data, response, error in
            // Verify that the error is not nil
            XCTAssertNotNil(error)

            // Verify the data is nil
            XCTAssertNil(data)

            expectation.fulfill()
        }
        task.resume()

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
}
