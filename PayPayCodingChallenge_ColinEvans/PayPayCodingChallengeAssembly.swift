//
//  PayPayCodingChallengeAssembly.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation

final class PayPayCodingChallengeAssembly: PayPayCodingChallengeAssembling {
  private let openExchangeCurrencyActor = HTTPRequestFetchingActor()
  private let requestResource = Resource<CurrencyRates>(
    json: URL(string: "https://openexchangerates.org/api/latest.json")!,
    source: .XCConfig
  )
  private var openExchangeCurrencyProvider: HTTPRequestProvider<CurrencyRates>!

  private(set) var availableCurrecnyProvider: AvailableCurrenciesProvider!
  let activeCurrencyProvider: SelectedCurrencyConverting = CurrencyToConvert()
  let currencyConverter = CurrencyConverter()

  func assemble() {
    openExchangeCurrencyProvider = HTTPRequestProvider(
      request: requestResource,
      actor: openExchangeCurrencyActor
    )
    
    availableCurrecnyProvider
      = AvailableCurrenciesProvider(openExchangeCurrencyProvider: openExchangeCurrencyProvider)
  }
}
