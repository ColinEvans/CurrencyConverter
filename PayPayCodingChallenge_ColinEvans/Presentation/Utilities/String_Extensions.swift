//
//  String_Extensions.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

extension String {
  /// Checks if the underlying `String` value is a `Double`
  ///
  /// - Returns:
  ///  `True` if the underlying `String` is a `Double` while trimming `all` whitespace and `False` otherwise
  func isValidNumber() -> Bool {
    let trimmedValue = self.replacingOccurrences(of: " ", with: "")
    return Double(trimmedValue) != nil
  }
}
