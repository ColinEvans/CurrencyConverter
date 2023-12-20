//
//  SelectedCurrecnyConverterMock.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation
import Combine

struct SelectedCurrecnyConverterMock: SelectedCurrencyConverting {
  let activeCurrencyValue = CurrentValueSubject<Double, Never>(.nan)
  let selectedCurrency = CurrentValueSubject<Currency?, Never>(nil)
}
