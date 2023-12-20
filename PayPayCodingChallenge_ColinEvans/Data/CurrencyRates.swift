//
//  CurrencyRates.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation

/// Models the format supplied by the `open exchange rate` API and translates the format into an app specific type
struct CurrencyRates: Codable {
  /// Data type fetched from the `open exchange rate` API
  let rates: [String: Double]
  
  /// Translates the fetched `rates` into the common `[Currency]` format
  ///
  ///  - Returns: An array of `Currency` where each entry is a key value pair from `rates`
  func convert() -> [Currency] {
    Self.convertToCurrency(from: rates)
  }

  /// Translates the fetched `rates` into a format usable by `UserDefaults`
  ///
  ///  - Returns: non-mutating, returning a dictionary of  `[String: NSNumber]` by converting the values of
  ///    the currencies into `NSNumber`
  func formatForUserDefaults() -> [String: NSNumber] {
    rates.mapValues {
      $0 as NSNumber
    }
  }
  
  /// Translates any `[String: NSNumber]` input into a `[Currency]`.
  /// Used for unwrapping `UserDefaults` stored value into a common format
  ///
  /// - Parameter storedRates: a dictionary of  `[String: NSNumber]` to convert
  /// - Returns: the mapped `[Currency]` representing the keys and values of the input
  static func formatToCurrency(for storedRates: [String: NSNumber]) -> [Currency] {
    let rates = storedRates.mapValues { $0.doubleValue }
    return convertToCurrency(from: rates)
  }
  
  private static func convertToCurrency(from rates: [String: Double]) -> [Currency] {
    var currencies = [Currency]()
    rates.forEach { key, value in
      currencies.append(
        Currency(code: key, rate: value)
      )
    }

    return currencies
  }
}
