//
//  AvailableCurrenciesProviderTests.swift
//  PayPayCodingChallenge_ColinEvansTests
//
//  Created by Colin Evans on 2023-12-17.
//

import XCTest

@testable import PayPayCodingChallenge_ColinEvans

final class AvailableCurrenciesProviderTests: XCTestCase {

  var mockHTTPProvider: HTTPRequestProviderMock!
  var sut: AvailableCurrenciesProvider!
  
  override func setUp() {
    super.setUp()
    mockHTTPProvider = HTTPRequestProviderMock(mockCurrencies: MockCurrencies.makeMockCurrencies())
    sut = AvailableCurrenciesProvider(
      openExchangeCurrencyProvider: mockHTTPProvider
    )
  }
  
  func test_refreshCurrencies_withValidTimer_ReturnsCurrencies() async {
    // Arrange
    let expected = MockCurrencies.makeMockCurrencies()

    // Act & Assert
    do {
      try await sut.refreshCurrencies()
      XCTAssertEqual(
        sut.currencies.value,
        expected
      )
    } catch {
      XCTFail()
    }
  }
  
  func test_refreshCurrencies_withInvalidTimer_throwsCurrencyError() async {
    // Act & Assert
    do {
      try await sut.refreshCurrencies()
      try await sut.refreshCurrencies()
      XCTFail()
    } catch let currencyError where currencyError is CurrencyError {
      XCTAssertNotNil(currencyError as? CurrencyError)
    } catch {
      XCTFail()
    }
  }
  
  func test_refreshCurrencies_throwingHTTPError_isCaught() async {
    // Arrange
    mockHTTPProvider.throwsError = true
    
    // Act & Assert
    do {
      try await sut.refreshCurrencies()
      XCTFail()
    } catch {
      XCTAssertNotNil(error as? HTTPRequestError)
    }
  }
  
  func test_checkRefreshTimeInSeconds_withoutRefresh_ReturnsNil() async {
    // Act & Assert
    let refreshTime = await sut.checkRefreshTimeInSeconds()
    XCTAssertNil(refreshTime)
  }
  
  func test_checkRefreshTimeInSeconds_afterRefresh_ReturnsNotNil() async {
    // Act & Assert
    do {
      try await sut.refreshCurrencies()
      let refreshTime = await sut.checkRefreshTimeInSeconds()
      XCTAssertNotNil(refreshTime)
    } catch {
      XCTFail()
    }
  }
}
