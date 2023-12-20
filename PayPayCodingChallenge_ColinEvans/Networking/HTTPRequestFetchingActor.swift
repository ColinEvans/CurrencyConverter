//
//  HTTPRequestFetchingActor.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

/// Concurrency mechanism to ensure that only a single thread is able the same `HTTPRequest`
///  at once.
actor HTTPRequestFetchingActor {
  /// Is an api request currently in progress
  var isFetching: Bool = false
  
  /// Updates the isFetching value to the new value
  /// - Parameter newValue: The new value to set to `isFetching`
  func updateIsFetching(to newValue: Bool) {
    isFetching = newValue
  }
}
