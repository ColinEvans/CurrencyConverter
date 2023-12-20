//
//  HTTPRequestProviderMock.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation

class HTTPRequestProviderMock: HTTPRequestProviding {
  
  var mockCurrencies = [Currency]()
  var throwsError: Bool
  
  init(mockCurrencies: [Currency], throwsError: Bool = false) {
    self.mockCurrencies = mockCurrencies
    self.throwsError = throwsError
  }
  
  func getLatestExchangeRates() async throws -> [Currency] {
    if throwsError {
      throw HTTPRequestError.fetchFailed
    }
    return mockCurrencies
  }
}
