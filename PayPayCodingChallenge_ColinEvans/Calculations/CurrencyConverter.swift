//
//  CurrencyConverter.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation

/// A `Currency` has a base rate relative to the `USD`. Each rate provided must first be converted to `USD`
/// before being applied to the given rate of a `Currency`.
struct CurrencyConverter {

  /// Converts amount into `USD` using the rate
  ///
  /// - Parameters:
  ///   - amount: The amount to be converted
  ///   - rate: The given rate, where 1 USD is equal to the rate
  /// - Returns: The amount converted to USD
  func convertToUSD(for amount: Double, rate: Double) -> Double {
    guard !amount.isNaN,
          !rate.isNaN,
          !rate.isZero else {
      return .nan
    }

    return amount / rate
  }

  /// Calculates the conversion of the amount provided for each available `Currency`
  ///
  /// - Parameters:
  ///   - amount: The amount in USD
  ///   - currencies: an array of `Currency` to be converted
  /// - Returns: An array of `ConvertedCurrency` containing the converted amount
  func applyUSDConversion(for amount: Double, to currencies: [Currency]) -> [ConvertedCurrency] {
    currencies.map {
      ConvertedCurrency(
        convertedAmount: amount * $0.rate,
        currency: $0
      )
    }
  }
}
