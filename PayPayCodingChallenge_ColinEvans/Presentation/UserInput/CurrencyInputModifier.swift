//
//  CurrencyInput.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation
import SwiftUI

extension View {
  func currencyInput(isInvalid: Bool) -> some View {
    self
      .padding()
      .font(.title2)
      .foregroundColor(.white)
      .background(Color.primaryBlue)
      .cornerRadius(20)
      .shadow(color: .gray, radius: 3)
      .overlay {
        RoundedRectangle(cornerRadius: 20.0)
          .stroke(isInvalid ? Color.red : .clear, lineWidth: 1.5)
      }
  }
}
