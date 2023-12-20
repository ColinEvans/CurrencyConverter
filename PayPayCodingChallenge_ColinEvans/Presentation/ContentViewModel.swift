//
//  ContentViewModel.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import Foundation

/// Main interface for the UI and the backend fetching the latest `Currency` values
/// Some assumptions I made inlcude:
///   - Whenever the user launches the application, an attempt will be made to fetch results
///   - The user must wait 30 minutes to fetch again, and must press the refresh button explicitly to trigger an API call
///   - If there is `any` error in completing the API request, a human readable response will be shown on screen
///   - This response will persist until a valid API call is completed
class ContentViewModel: ObservableObject {
  /// A human readable error if accessing the `Currency` values fails
  @Published var errorToShow: String?
  /// If the currency exchange table is visible or not
  @Published var isTableVisible = false

  private let currencyProvider: any AvailableCurrenciesProviding
  
  init(
    currencyProvider: some AvailableCurrenciesProviding,
    activeCurrencyValueProvider: some ActiveCurrencyValueProviding
  ) {
    self.currencyProvider = currencyProvider
    activeCurrencyValueProvider
      .activeCurrencyValue
      .map { !$0.isNaN }
      .assign(to: &$isTableVisible)
  }

  /// Makes an asynchronous API call to populate an array of available currency codes and values
  ///  If there is an error encountered then it will be propogated to the user
  ///  If saved currency exchange rates are cached, they will be shown to the user in place of the up to date values
  func fetch() async {
    do {
      try await currencyProvider.refreshCurrencies()
      DispatchQueue.main.async {
        self.errorToShow = nil
      }
    } catch let error where error is CurrencyError {
      let remainingTimeInMinutes = await getRemainingTimeAsString()
      DispatchQueue.main.async {
        self.errorToShow = String(format: String(describing: error), remainingTimeInMinutes)
      }
    } catch let error where error is HTTPRequestError {
      DispatchQueue.main.async {
        self.setUserDefaultsErrorText(for: error.localizedDescription)
        self.useDefaults()
      }
    } catch {
      DispatchQueue.main.async {
        self.setUserDefaultsErrorText(for: error.localizedDescription)
        self.useDefaults()
      }
    }
  }

  private func getRemainingTimeAsString() async -> String {
    guard let remainingTime = await currencyProvider.checkRefreshTimeInSeconds() else {
      return ""
    }
    
    let remainingTimeAsInt = Int(remainingTime / 60)
    return String(remainingTimeAsInt)
  }

  private func setUserDefaultsErrorText(for errorString: String) {
    errorToShow = """
    \(errorString)
    \nUsing offline data.
    \nPlease use the refresh button to try again.
    """
  }
  
  private func useDefaults() {
    guard let storedValue
            = UserDefaults.standard.dictionary(forKey: "offline-currencies") as? [String: NSNumber] else {
      errorToShow = "Stored data corrupted, unable to load"
      return
    }
    let translatedData = CurrencyRates
      .formatToCurrency(for: storedValue)
      .sorted() { $0.id < $1.id }
    currencyProvider.currencies.send(translatedData)
  }
}

// MARK: - SwiftUI Preview
extension ContentViewModel {
  static func preview() -> ContentViewModel {
    ContentViewModel(
      currencyProvider: AvailableCurrenciesProviderMock(),
      activeCurrencyValueProvider: SelectedCurrecnyConverterMock()
    )
  }
}
