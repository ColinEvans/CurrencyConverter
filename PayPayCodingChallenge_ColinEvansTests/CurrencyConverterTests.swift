//
//  CurrencyConverterTests.swift
//  PayPayCodingChallenge_ColinEvansTests
//
//  Created by Colin Evans on 2023-12-17.
//

import XCTest

@testable import PayPayCodingChallenge_ColinEvans

final class CurrencyConverterTests: XCTestCase {
  // Accuracy threshold set to 4 digits
  static let accuracyThreshold = 0.0001

  func test_convertToUSD_rateNoDecimalAboveOne_ReturnsExpected() {
    // Arrange
    let sut = CurrencyConverter()
    let amount = 100.0
    let rate = 1.25
    let expected = 80.0
    
    // Act & Assert
    XCTAssertEqual(sut.convertToUSD(for: amount, rate: rate), expected)
  }
  
  func test_convertToUSD_rateWithDecimalAboveOne_ReturnsExpected() {
    // Arrange
    let sut = CurrencyConverter()
    let amount = 100.0
    let rate = 1.33925
    let expected = 74.6686578309
    
    // Act & Assert
    XCTAssertEqual(
      sut.convertToUSD(for: amount, rate: rate),
      expected,
      accuracy: Self.accuracyThreshold
    )
  }
  
  func test_convertToUSD_rateCloseToZero_ReturnsExpected() {
    // Arrange
    let sut = CurrencyConverter()
    let amount = 100.0
    let rate = 0.000023322813
    let expected = 4_287_647.4634513427
    
    // Act & Assert
    XCTAssertEqual(
      sut.convertToUSD(for: amount, rate: rate),
      expected,
      accuracy: Self.accuracyThreshold
    )
  }
  
  func test_convertToUSD_withZeroAmount_ReturnsZero() {
    // Arrange
    let sut = CurrencyConverter()
    let amount = 0.0
    let rate = 1222.88
    let expected = 0.0
    
    // Act & Assert
    XCTAssertEqual(
      sut.convertToUSD(for: amount, rate: rate),
      expected,
      accuracy: Self.accuracyThreshold
    )
  }
  
  func test_convertToUSD_withNaNAmount_returnsNaN() {
    // Arrange
    let sut = CurrencyConverter()
    let amount: Double = .nan
    let rate = 1222.88
    
    // Act & Assert
    XCTAssertTrue(sut.convertToUSD(for: amount, rate: rate).isNaN)
  }
  
  func test_convertToUSD_withNaNRate_returnsNaN() {
    // Arrange
    let sut = CurrencyConverter()
    let amount = 1337.27
    let rate: Double = .nan
    
    // Act & Assert
    XCTAssertTrue(sut.convertToUSD(for: amount, rate: rate).isNaN)
  }
  
  func test_convertToUSD_WithZeroRate_returnsNaN() {
    // Arrange
    let sut = CurrencyConverter()
    let amount = 1337.27
    let rate = 0.0
    
    // Act & Assert
    XCTAssertTrue(sut.convertToUSD(for: amount, rate: rate).isNaN)
  }
  
  func test_applyUSDConversion_withPositiveAmountAndRateAboveOne_ReturnsExpectedCurrency() {
    // Arrange
    let sut = CurrencyConverter()
    let amount = 10.0
    let currencies = [
      Currency(code: "AED", rate: 3.65),
      Currency(code: "AFN", rate: 69.325),
      Currency(code: "ALL", rate: 94.033)
    ]
    let expected = [
      ConvertedCurrency(convertedAmount: 36.5, currency: currencies[0]),
      ConvertedCurrency(convertedAmount: 693.25, currency: currencies[1]),
      ConvertedCurrency(convertedAmount: 940.33, currency: currencies[2])
    ]
    
    // Act
    let results = sut.applyUSDConversion(for: amount, to: currencies)
    
    // Assert
    for index in 0..<3 {
      XCTAssertEqual(
        expected[index],
        results[index]
      )
    }
  }
  
  func test_applyUSDConversion_withPositiveAmountAndRateBelowOne_ReturnsExpectedCurrency() {
    // Arrange
    let sut = CurrencyConverter()
    let amount = 10.0
    let currencies = [
      Currency(code: "AED", rate: 0.1),
      Currency(code: "AFN", rate: 0.5),
      Currency(code: "ALL", rate: 0.99)
    ]
    let expected = [
      ConvertedCurrency(convertedAmount: 1, currency: currencies[0]),
      ConvertedCurrency(convertedAmount: 5, currency: currencies[1]),
      ConvertedCurrency(convertedAmount: 9.9, currency: currencies[2])
    ]
    
    // Act
    let results = sut.applyUSDConversion(for: amount, to: currencies)
    
    // Assert
    for index in 0..<3 {
      XCTAssertEqual(
        expected[index],
        results[index]
      )
    }
  }
}
