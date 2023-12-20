//
//  StringIsValidNumberTests.swift
//  PayPayCodingChallenge_ColinEvansTests
//
//  Created by Colin Evans on 2023-12-14.
//

import XCTest

@testable import PayPayCodingChallenge_ColinEvans

final class StringIsValidNumberTests: XCTestCase {
  
  func test_IsValidNumber_WithValidInteger_ReturnsTrue() {
    // Arrange
    let sut = "1337"
    
    // Act & Assert
    XCTAssertTrue(sut.isValidNumber())
  }
  
  func test_IsValidNumber_WithValidDouble_ReturnsTrue() {
    // Arrange
    let sut = "1000000.41"
    
    // Act & Assert
    XCTAssertTrue(sut.isValidNumber())
  }
  
  func test_IsValidNumber_WithValidDoubleAndWhitespace_ReturnsTrue() {
    // Arrange
    let sut = "100 00 0            0.41"
    
    // Act & Assert
    XCTAssertTrue(sut.isValidNumber())
  }
  
  func test_IsValidNumber_WithInvalidCharacterInput_ReturnsFalse() {
    // Arrange
    let sut = "100_000"
    
    // Act & Assert
    XCTAssertFalse(sut.isValidNumber())
  }
  
  func test_IsValidNumber_WithInvalidSpecialCharacterInput_ReturnsFalse() {
    // Arrange
    let sut = "$100000.47"
    
    // Act & Assert
    XCTAssertFalse(sut.isValidNumber())
  }
}
