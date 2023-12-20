//
//  SelectedCurrencyProviding.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation
import Combine

/// Models a provider of the currently selected currency from a supplied array of `Currency`
protocol SelectedCurrencyProviding {
  /// The currently selected currency from the provided `[Currency]` results
  var selectedCurrency: CurrentValueSubject<Currency?, Never> { get }
}
