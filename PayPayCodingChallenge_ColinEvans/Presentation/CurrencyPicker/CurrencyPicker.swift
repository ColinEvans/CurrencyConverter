//
//  CurrencyPicker.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import SwiftUI

struct CurrencyPicker: View {
  @ObservedObject var viewModel: CurrencyPickerViewModel

  var body: some View {
    GeometryReader { proxy in
      Picker(
        "Select a local currency",
        selection: $viewModel.selectedCurrency
      ) {
        ForEach(viewModel.currencies) {
          Text($0.code)
            .tag(Currency?.some($0))
        }
      }
      .tint(Color.pickerAccent)
      .frame(width: proxy.size.width * UIConstants.widthRatio)
      .overlay {
        RoundedRectangle(cornerRadius: 15.0)
          .stroke(Color.pickerAccent)
      }
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
        alignment: .trailing
      )
      .padding(.trailing)
    }
  }
  
  private struct UIConstants {
    static let widthRatio: CGFloat = 0.35
  }
}

#Preview {
  CurrencyPicker(viewModel: CurrencyPickerViewModel.preview())
}
