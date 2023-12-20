//
//  ContentView.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-15.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var userInputViewModel: UserInputViewModel
  @ObservedObject var pickerViewModel: CurrencyPickerViewModel
  @ObservedObject var listViewModel: ConversionListViewModel
  @ObservedObject var contentViewModel: ContentViewModel

  var body: some View {
    GeometryReader { proxy in
      VStack(spacing: proxy.size.height * UIConstants.itemSpacing) {
        Text("Currency Converter")
          .foregroundStyle(Color.white)
          .font(.title)
        UserInputView(viewModel: userInputViewModel)
          .padding(.top)
          .frame(
            maxHeight: proxy.size.height * UIConstants.numberConverterHeightRatio
          )
        HStack(alignment: .center) {
          RefreshButton(viewModel: contentViewModel)
          CurrencyPicker(viewModel: pickerViewModel)
            .frame(
              maxHeight: proxy.size.height * UIConstants.currencyPickerHeightRatio
            )
        }

        .padding([.leading, .trailing])
        if contentViewModel.isTableVisible {
          ConversionListView(viewModel: listViewModel)
            .frame(
              maxWidth: proxy.size.width * UIConstants.currencyTableWidthRatio,
              maxHeight: proxy.size.height * UIConstants.currencyTableHeightRatio
            )
        }

        if let error = contentViewModel.errorToShow {
          Text(error)
            .foregroundStyle(Color.white)
            .font(.footnote)
        }
        Spacer()
      }
      .background(Color.background)
      .task {
        await contentViewModel.fetch()
      }
    }
  }
  
  private struct UIConstants {
    static let numberConverterHeightRatio: CGFloat = 0.2
    static let currencyPickerHeightRatio: CGFloat = 0.1
    static let currencyTableWidthRatio: CGFloat = 0.75
    static let currencyTableHeightRatio: CGFloat = 0.6
    static let itemSpacing: CGFloat = 0.05
  }
}

#Preview {
  ContentView(
    userInputViewModel: .preview(),
    pickerViewModel: .preview(),
    listViewModel: .preview(),
    contentViewModel: .preview()
  )
}
