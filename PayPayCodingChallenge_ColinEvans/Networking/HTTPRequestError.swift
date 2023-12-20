//
//  HTTPRequestError.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

/// Possible `Error` states for the HTTP client
enum HTTPRequestError: Error {
  case fetchFailed
  case badServerResponse
  case incorrectDataResponse
}

// MARK: - Extension<CustomStringConvertible>
extension HTTPRequestError: CustomStringConvertible {
  var description: String {
    switch self {
    case .fetchFailed:
      return "Failed to connect to the server please try again."
    case .badServerResponse:
      return "Invalid response from the server."
    case .incorrectDataResponse:
      return "The data returned from the server is invalid."
    }
  }
}
