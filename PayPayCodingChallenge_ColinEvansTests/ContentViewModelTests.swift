//
//  ContentViewModelTests.swift
//  PayPayCodingChallenge_ColinEvansTests
//
//  Created by Colin Evans on 2023-12-17.
//

import XCTest

@testable import PayPayCodingChallenge_ColinEvans

final class ContentViewModelTests: XCTestCase {
  
  var mockCurrencyProvider: AvailableCurrenciesProviderMock!
  var activeCurrencyValueProvider: ActiveCurrencyValueProviderMock!
  var sut: ContentViewModel!
  
  override func setUp() {
    super.setUp()
    mockCurrencyProvider = AvailableCurrenciesProviderMock()
    activeCurrencyValueProvider = ActiveCurrencyValueProviderMock()
    sut = ContentViewModel(
      currencyProvider: mockCurrencyProvider,
      activeCurrencyValueProvider: activeCurrencyValueProvider
    )
  }
  
  func test_fetch_withValidRequest_hasNoError() async {
    await sut.fetch()
    XCTAssertNil(sut.errorToShow)
  }
  
  @MainActor
  func test_fetch_withCurrencyError_populatesErrorToShow() async {
    mockCurrencyProvider.throwsCurrencyError = true
    await sut.fetch()
   
    XCTAssertNotNil(self.sut.errorToShow)
  }
  
  @MainActor
  func test_fetch_withHTTPError_populatesErrorToShow() async {
    mockCurrencyProvider.throwsHTTPError = true
    await sut.fetch()
    XCTAssertNotNil(sut.errorToShow)
  }
  
  @MainActor
  func test_fetch_withGenericError_populatesErrorToShow() async {
    mockCurrencyProvider.throwsGenericError = true
    await sut.fetch()
    XCTAssertNotNil(sut.errorToShow)
  }
}
