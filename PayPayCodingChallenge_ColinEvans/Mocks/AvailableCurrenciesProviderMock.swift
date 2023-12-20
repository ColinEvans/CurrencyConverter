//
//  AvailableCurrenciesProviderMock.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation
import Combine

class AvailableCurrenciesProviderMock: AvailableCurrenciesProviding {
  let currencies = CurrentValueSubject<[Currency], Never>([])
  var throwsHTTPError = false
  var throwsCurrencyError = false
  var throwsGenericError = false
  
  func refreshCurrencies() async throws {
    if throwsHTTPError {
      throw HTTPRequestError.fetchFailed
    } else if throwsCurrencyError {
      throw CurrencyError.notEnoughTime
    } else if throwsGenericError {
      throw URLError(.notConnectedToInternet)
    }
  }

  func checkRefreshTimeInSeconds() async -> TimeInterval? { nil }
}
