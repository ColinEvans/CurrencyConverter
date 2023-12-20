//
//  URLSessionTests.swift
//  PayPayCodingChallenge_ColinEvansTests
//
//  Created by Colin Evans on 2023-12-17.
//

import XCTest
import Mocker

@testable import PayPayCodingChallenge_ColinEvans

final class URLSessionTests: XCTestCase {
  
  var sessionManager: URLSession!
  let mockURL = URL(string: "www.someExample.com")!
  private var sut: Resource<MockData>!
  private var expectedResult: MockData!
  private var encodedResult: Data!
  
  override func setUp() {
    super.setUp()
    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
    sessionManager = URLSession(configuration: configuration)

    expectedResult = MockData(testInt: 42, testString: "Hello")
    sut = Resource(
      url: mockURL,
      parse: {
        guard let value = try? JSONDecoder().decode(MockData.self, from: $0) else {
          throw MockDataError.dataNotFound
        }
        return value
      },
      source: .XCConfig
    )
    encodedResult = try! JSONEncoder().encode(expectedResult)
  }
  
  func test_load_withEncodedDataAndStatus200_matchesExpected() async throws {
    // Arrange
    let mock = Mock(url: mockURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [.get: encodedResult])
    
    // Act
    mock.register()
    let result = try await sessionManager.load(resource: sut)
    
    // Assert
    XCTAssertEqual(result, expectedResult)
  }
  
  func test_load_throwsBadServerResponse_matchesExpected() async throws {
    // Arrange
    let mock = Mock(url: mockURL, ignoreQuery: true, dataType: .json, statusCode: 400, data: [.get: encodedResult])
    
    // Act & Assert
    mock.register()
    
    do {
      let _ = try await sessionManager.load(resource: sut)
    } catch(let error) {
      guard let urlError = error as? URLError,
            urlError.code == .badServerResponse else {
        XCTFail()
        return
      }
    }
  }
  
  private struct MockData: Codable, Equatable {
    let testInt: Int
    let testString: String
  }
  
  private enum MockDataError: Error {
    case dataNotFound
  }
}
