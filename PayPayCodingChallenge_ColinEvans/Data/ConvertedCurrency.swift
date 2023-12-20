//
//  ConvertedCurrency.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation

/// Holds the converted currency from user input  multiplied by the `Currency` exchange rate
struct ConvertedCurrency: Identifiable {
  var id: Currency {
    currency
  }
  
  /// The converted amount local to the `Currency`
  let convertedAmount: Double

  /// A reference for the calculated amount
  let currency: Currency
}

// MARK: -  Extensions<Equatable>
extension ConvertedCurrency: Equatable {}

extension ConvertedCurrency {
  static func preview() -> ConvertedCurrency {
    ConvertedCurrency(
      convertedAmount: 1337.1001,
      currency: Currency(code: "CAD", rate: 1.36)
    )
  }
}
