//
//  CurrencyToConvert.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation
import Combine

/// Singleton instance providing consumers with both the selected currency and the provided value to be converted
struct CurrencyToConvert: ActiveCurrencyValueProviding, SelectedCurrencyProviding {
  let activeCurrencyValue = CurrentValueSubject<Double, Never>(.nan)
  let selectedCurrency = CurrentValueSubject<Currency?, Never>(nil)
}
