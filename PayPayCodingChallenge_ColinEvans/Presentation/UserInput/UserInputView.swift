//
//  UserInputView.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import SwiftUI

struct UserInputView: View {
  @ObservedObject var viewModel: UserInputViewModel
  
  var body: some View {
    GeometryReader { proxy in
      VStack {
        userInput
        
        if viewModel.isInputInvalid {
          Text("Please input a valid number using only space and decimal")
            .foregroundStyle(Color.white)
            .background(Color.background)
        }
      }
      .frame(width: proxy.size.width * UIConstants.widthRatio)
      .frame(maxWidth: .infinity)
    }
  }

  private var userInput: some View {
    HStack {
      if viewModel.isInputInvalid {
        Image(systemName: "exclamationmark.triangle")
          .font(.system(size: 25))
          .foregroundStyle(Color.gray)
      }
      TextField(
        "# ### ##.##",
        text: $viewModel.numberToExchange
      )
    }
    .currencyInput(isInvalid: viewModel.isInputInvalid)
  }

  private struct UIConstants {
    static let widthRatio: CGFloat = 0.9
  }
}

#Preview {
  UserInputView(viewModel: .preview())
}
