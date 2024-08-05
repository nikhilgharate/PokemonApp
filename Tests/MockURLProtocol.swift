//
//  MockURLProtocol.swift
//  PokemonApp
//
//  Created by iAURO on 31/07/24.
//
import Foundation

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        // Ensure that the request handler is set
        guard let handler = MockURLProtocol.requestHandler else {
            // Log a meaningful message for debugging
            print("Error: MockURLProtocol requestHandler is not set.")
            self.client?.urlProtocol(self, didFailWithError: NSError(domain: "MockURLProtocolErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request handler not set."]))
            return
        }

        let (response, data) = handler(request)

        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let data = data {
            self.client?.urlProtocol(self, didLoad: data)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // This method is required but doesn't need any implementation for the mock
    }
}
