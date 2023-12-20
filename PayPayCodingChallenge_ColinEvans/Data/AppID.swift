//
//  AppID.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

/// `AppID` is used by the client to authorize API calls to the `open exchange rates` API
struct AppID {
  /// `Source` is method on how the underlying `AppID` value is retrivied
  enum Source {
    case XCConfig
  }
  
  /// The source of the `AppID`
  let source: Source

  /// Calculates the underlying `AppID` value from the `Source`
  var value: String {
    switch source {
    case .XCConfig:
      guard let appIdString = Bundle.main.object(forInfoDictionaryKey: "App_ID") as? String else {
        fatalError("Unable to load AppID from the XCConfig file, please ensure the App_ID exists.")
      }
      return appIdString
    }
  }
}
