//
//  PayPayCodingChallenge_ColinEvansApp.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import SwiftUI

@main
struct PayPayCodingChallenge_ColinEvansApp: App {
  let assembly = PayPayCodingChallengeAssembly()
  let userInputViewModel: UserInputViewModel
  let currencyPickerViewModel: CurrencyPickerViewModel
  let listViewModel: ConversionListViewModel
  let contentViewModel: ContentViewModel
  
  init() {
    assembly.assemble()
    userInputViewModel = UserInputViewModel(
      activeCurrencyValueConverter: assembly.activeCurrencyProvider
    )
    currencyPickerViewModel = CurrencyPickerViewModel(
      currencies: assembly
        .availableCurrecnyProvider
        .currencies
        .eraseToAnyPublisher(),
      selectedCurrencyProvider: assembly.activeCurrencyProvider
    )
    listViewModel = ConversionListViewModel(
      currencies: assembly
        .availableCurrecnyProvider
        .currencies
        .eraseToAnyPublisher(),
      currencyToConvert: assembly.activeCurrencyProvider,
      currencyConverter: assembly.currencyConverter
    )
    contentViewModel = ContentViewModel(
      currencyProvider: assembly.availableCurrecnyProvider,
      activeCurrencyValueProvider: assembly.activeCurrencyProvider
    )
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView(
        userInputViewModel: userInputViewModel,
        pickerViewModel: currencyPickerViewModel,
        listViewModel: listViewModel,
        contentViewModel: contentViewModel
      )
    }
  }
}
