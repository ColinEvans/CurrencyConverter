//
//  CurrencyRatesTests.swift
//  PayPayCodingChallenge_ColinEvansTests
//
//  Created by Colin Evans on 2023-12-17.
//

import XCTest

@testable import PayPayCodingChallenge_ColinEvans

final class CurrencyRatesTests: XCTestCase {
  private var testAPIResults: [String: Double]!
  
  override func setUp() {
    super.setUp()
    testAPIResults = [
      "CAD": 1.35,
      "AUD": 1.67,
      "EUR": 0.92
    ]
  }
  
  func test_convert_withThreeValues_matchesExpected() {
    // Arrange
    let sut = CurrencyRates(rates: self.testAPIResults)
    let expected = [
      Currency(code: "CAD", rate: 1.35),
      Currency(code: "AUD", rate: 1.67),
      Currency(code: "EUR", rate: 0.92)
    ]
    
    // Act
    let results = sut.convert()
    
    // Assert
    for currency in expected {
      if !results.contains(currency) {
        XCTFail()
      }
    }
  }
  
  func test_convert_withEmptyDictionary_ReturnsEmptyArray() {
    // Arrange
    let sut = CurrencyRates(rates: [:])

    // Act
    let results = sut.convert()
    
    // Assert
    XCTAssertTrue(results.isEmpty)
  }
  
  func test_formatForUserDefaults_withThreeValues_matchesExpected() {
    // Arrange
    let sut = CurrencyRates(rates: self.testAPIResults)
    let expected = [
      "CAD": 1.35 as NSNumber,
      "AUD": 1.67 as NSNumber,
      "EUR": 0.92 as NSNumber
    ]
    
    // Act
    let results = sut.formatForUserDefaults()
    
    // Assert
    for key in expected.keys {
      guard results[key] == expected[key] else {
        XCTFail()
        return
      }
    }
  }

  func test_formatForUserDefaults_withEmptyDictionary_ReturnsEmptyArray() {
    // Arrange
    let sut = CurrencyRates(rates: [:])
    
    // Act
    let results = sut.formatForUserDefaults()
    
    // Assert
    XCTAssertTrue(results.isEmpty)
  }
}
