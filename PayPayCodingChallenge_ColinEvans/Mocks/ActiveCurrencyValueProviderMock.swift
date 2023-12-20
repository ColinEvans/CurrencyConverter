//
//  ActiveCurrencyValueProviderMock.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-17.
//

import Foundation
import Combine

class ActiveCurrencyValueProviderMock: ActiveCurrencyValueProviding {
  var activeCurrencyValue = CurrentValueSubject<Double, Never>(.nan)
  
  init(currencyValue: Double? = nil) {
    if let currencyValue {
      activeCurrencyValue.send(currencyValue)
    }
  }
}
