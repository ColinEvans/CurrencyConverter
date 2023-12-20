//
//  UserInputViewModel.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation
import SwiftUI
import Combine

/// Allows the user to enter the amount they wish to be converted
/// Some assumptions I made inlcude:
///   - Acceptable inputs include only numeric values, spaces and decimals
///   - Incorrect formatting will be propagated to the user to fix before any currency exchange rates are calculated
///   - If there is invalid input, a message will be shown to the user
final class UserInputViewModel: ObservableObject {
  /// The supplied input to be converted
  @Published var numberToExchange = ""
  /// whether or not the currently supplied input is valid
  @Published var isInputInvalid = false

  private var cancellables = Set<AnyCancellable>()
  
  init(activeCurrencyValueConverter: some ActiveCurrencyValueProviding) {
    $numberToExchange
      .filter { !$0.isEmpty }
      .map { !$0.isValidNumber() }
      .receive(on: DispatchQueue.main)
      .assign(to: &$isInputInvalid)
    
    $numberToExchange
      .filter { $0.isValidNumber() }
      .compactMap {
        Double($0.replacingOccurrences(of: " ", with: ""))
      }
      .sink {
        activeCurrencyValueConverter
          .activeCurrencyValue
          .send($0)
      }
      .store(in: &cancellables)
    
    $numberToExchange
      .filter { !$0.isValidNumber() }
      .map { _ in Double.nan }
      .sink {
        activeCurrencyValueConverter
          .activeCurrencyValue
          .send($0)
      }
      .store(in: &cancellables)
  }
}

// MARK: - SwiftUI Preview
extension UserInputViewModel {
  static func preview() -> UserInputViewModel {
    UserInputViewModel(
      activeCurrencyValueConverter: SelectedCurrecnyConverterMock()
    )
  }
}
