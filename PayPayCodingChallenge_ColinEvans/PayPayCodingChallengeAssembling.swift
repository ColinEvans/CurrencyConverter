//
//  PayPayCodingChallengeAssembling.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation

typealias SelectedCurrencyConverting = ActiveCurrencyValueProviding & SelectedCurrencyProviding

/// Models the setup code required to start the application
protocol PayPayCodingChallengeAssembling {
  var availableCurrecnyProvider: AvailableCurrenciesProvider! { get }
  var activeCurrencyProvider: SelectedCurrencyConverting { get }
  var currencyConverter: CurrencyConverter { get }

  /// Called by the client in order to setup the dependencies in the application
  func assemble()
}
