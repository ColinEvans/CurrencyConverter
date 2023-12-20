//
//  ConversionListViewModel.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation
import Combine

/// Populates a table with the most up to date `ConvertedCurrency` provided by both
///  the given exchange rate and user input
///  Some assumptions I made inlcude:
///   - No rounding on the presented result to maintain accuracury
///   - Updates to the table happen whenever a typed value by the user changes
///   - If there is no valid conversion then the table is hidden
final class ConversionListViewModel: ObservableObject {

  /// The most up to date converted values for the exchange rate and the user input values
  @Published var convertedCurrencies = [ConvertedCurrency]()
  private var cancellables = Set<AnyCancellable>()
  
  init(
    currencies: AnyPublisher<[Currency], Never>,
    currencyToConvert: SelectedCurrencyConverting,
    currencyConverter: CurrencyConverter
  ) {
    currencyToConvert.activeCurrencyValue
      .combineLatest(
        currencies,
        currencyToConvert.selectedCurrency
      )
      .sink { [weak self] value, currencies, selectedCurrency in
        guard let self = self,
          let selectedCurrency = selectedCurrency else { return }
        
        let valueInUSD = currencyConverter.convertToUSD(for: value, rate: selectedCurrency.rate)
        let convertedCurrencies
          = currencyConverter.applyUSDConversion(for: valueInUSD, to: currencies)

        DispatchQueue.main.async {
          self.convertedCurrencies = convertedCurrencies
        }
      }
      .store(in: &cancellables)
  }
}

// MARK: - SwiftUI Preview
extension ConversionListViewModel {
  static func preview() -> ConversionListViewModel {
    let publisher = CurrentValueSubject<[Currency], Never>([])
    publisher.send(MockCurrencies.makeMockCurrencies())
    let selectedCurrencyConverterMock = SelectedCurrecnyConverterMock()
    selectedCurrencyConverterMock.activeCurrencyValue.send(100.0)
    selectedCurrencyConverterMock.selectedCurrency.send(Currency(code: "CAD", rate: 1.36))
    
    return ConversionListViewModel(
      currencies: publisher.eraseToAnyPublisher(),
      currencyToConvert: selectedCurrencyConverterMock,
      currencyConverter: CurrencyConverter()
    )
  }
}
