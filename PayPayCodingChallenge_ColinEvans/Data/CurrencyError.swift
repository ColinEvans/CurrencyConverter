//
//  CurrencyError.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation

/// Possible `Error` when fetching `Currency` values outside of an `HTTPRequest`
enum CurrencyError: Error {
  case notEnoughTime
}

// MARK: - Extensions<CustomStringConvertible>
extension CurrencyError: CustomStringConvertible {
  var description: String {
    switch self {
    case .notEnoughTime:
      return "Not enough time has passed please wait %@ minutes and try again."
    }
  }
}
