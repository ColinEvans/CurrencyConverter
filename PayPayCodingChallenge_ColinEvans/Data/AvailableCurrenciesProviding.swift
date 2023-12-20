//
//  AvailableCurrenciesProviding.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation
import Combine

/// Models an interface that interactes with the `open exchange rate` API in order to provide
/// the most up to date values of currencies within a given time window.
protocol AvailableCurrenciesProviding {
  /// The most up to date array of `Currency` that can subscribed to
  var currencies: CurrentValueSubject<[Currency], Never> { get }

  /// Refreshs the list of currencies from the `open exchange rate` API.
  /// - Throws:
  ///  - `HTTPRequestError` if there's a networking issues
  ///  - `CurrencyError` if it has not been 30 minutes since the last refresh
  func refreshCurrencies() async throws

  /// Checks the time since the last request to the `open exchange rate` API
  ///
  /// - Returns: The remaining time if the API is currently unavailable to refresh  and `nil` otherwise
  func checkRefreshTimeInSeconds() async -> TimeInterval?
}
