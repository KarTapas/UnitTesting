//
//  MockURLProtocol.swift
//  LoginPageUnitTesting
//
//  Created by Tapas Kumar Kar on 20/09/23.
//

import Foundation

class MockURLProtocol: URLProtocol {
    // Define a static dictionary to map URLs to mock responses
    static var mockResponses: [URL: Data] = [:]

    // Override the canInit(with:) method to determine if this protocol should handle the request
    override class func canInit(with request: URLRequest) -> Bool {
        // Check if the URL is present in mockResponses
        return mockResponses[request.url!] != nil
    }

    // Override the canonicalRequest(for:) method
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    // Override the startLoading() method to provide the mock response data
    override func startLoading() {
        // Get the request's URL
        guard let url = request.url else { return }

        // Check if a mock response exists for this URL
        if let mockData = MockURLProtocol.mockResponses[url] {
            // Create a response with HTTP status code 200 (OK)
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

            // Inform the client that the request is complete and provide the mock response
            client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: mockData)
        }

        // Inform the client that the request is complete
        client?.urlProtocolDidFinishLoading(self)
    }

    // Override the stopLoading() method (optional)
    override func stopLoading() {
        // Handle any cleanup or additional actions if needed
    }
}

