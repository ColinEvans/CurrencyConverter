//
//  MockCurrencies.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation

struct MockCurrencies {
  static func makeMockCurrencies() -> [Currency] {
    [
      Currency(code: "AED", rate: 3.6727),
      Currency(code: "AFN", rate: 69.305489),
      Currency(code: "ALL", rate: 94.039901),
      Currency(code: "AMD", rate: 402.104686),
      Currency(code: "ANG", rate: 1.793221),
      Currency(code: "AOA", rate: 830.598333),
      Currency(code: "ARS", rate: 785.006378),
      Currency(code: "AUD", rate: 1.488747)
    ]
  }
}
