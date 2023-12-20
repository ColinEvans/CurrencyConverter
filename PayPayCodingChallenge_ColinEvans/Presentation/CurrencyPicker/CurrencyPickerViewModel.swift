//
//  CurrencyPickerViewModel.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation
import Combine

/// Interfaces between the supplied `Currency` array to a picker presented to the user
/// Some assumptions I made inlcude:
///   - All available currencies will be shown in alphabetcial order
///   - The selection will default to the first item in the array
final class CurrencyPickerViewModel: ObservableObject {
  /// The available currencies that can be selected
  @Published var currencies = [Currency]()
  /// The currently selected `Currency` value, defaults to `nil` if none are available
  @Published var selectedCurrency: Currency?
  
  private var cancellables = Set<AnyCancellable>()
  
  init(
    currencies: AnyPublisher<[Currency], Never>,
    selectedCurrencyProvider: some SelectedCurrencyProviding
  ) {
    currencies
      .receive(on: DispatchQueue.main).sink { [weak self] currencies in
        self?.currencies = currencies
        self?.selectedCurrency = currencies.first
      }
      .store(in: &cancellables)
    
    $selectedCurrency
      .removeDuplicates()
      .sink {
        selectedCurrencyProvider.selectedCurrency.send($0)
      }
      .store(in: &cancellables)
  }
}

// MARK: - SwiftUI Preview
extension CurrencyPickerViewModel {
  static func preview() -> CurrencyPickerViewModel {
    let currencies = MockCurrencies.makeMockCurrencies()
    let currencyProviderMock = AvailableCurrenciesProviderMock()
    currencyProviderMock.currencies.send(currencies)

    return CurrencyPickerViewModel(
      currencies: currencyProviderMock.currencies.eraseToAnyPublisher(),
      selectedCurrencyProvider: SelectedCurrecnyConverterMock()
    )
  }
}
