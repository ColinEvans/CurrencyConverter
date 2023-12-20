//
//  HTTPRequestProviding.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

/// Models a HTTP Request for retriving the latest exchange rate list and values from
/// the `open exchange rates` API
/// see: https://docs.openexchangerates.org/reference/latest-json
protocol HTTPRequestProviding {
  
  /// Makes an API request to a supplied endpoint and and provides the most
  ///  up to date array of `Currency` values
  ///
  ///  - Throws `HTTPRequestError`:  if an issue with the network occurs
  ///  - Returns: A list of `Currency` provided by the endpoint
  func getLatestExchangeRates() async throws -> [Currency]
}
