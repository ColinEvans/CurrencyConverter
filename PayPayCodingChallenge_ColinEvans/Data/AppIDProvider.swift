//
//  AppIDProvider.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

@propertyWrapper
/// Convenience wrapper to retrieve the `AppID` given the `Source`
struct AppIDProvider {
  var wrappedValue: AppID
  
  init(_ wrappedValue: AppID.Source) {
    self.wrappedValue = AppID(source: wrappedValue)
  }
}
