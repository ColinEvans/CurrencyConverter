//
//  ActiveCurrencyValueProviding.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation
import Combine

/// Models a provider of the most up to date currency amount given by a user
protocol ActiveCurrencyValueProviding {
  /// The most up to date currecny value provided
  var activeCurrencyValue: CurrentValueSubject<Double, Never> { get }
}
