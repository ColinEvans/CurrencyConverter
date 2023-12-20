//
//  Currency.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

/// Representation of a international currency with a currency code and an exchange rate
struct Currency: Identifiable {
  /// The free tier of the `open exchange rates` api models all exchange rates with a base of the `USD`
  static let baseCurrency = "USD"

  var id: String {
    code
  }
  
  /// The currency code used to iden
  let code: String

  /// The exchange rate relative to the `USD`
  let rate: Double
}

// MARK: -  Extensions<Hashable>
extension Currency: Hashable {}
