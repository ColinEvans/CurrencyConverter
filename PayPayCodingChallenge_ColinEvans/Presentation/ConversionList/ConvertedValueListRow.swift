//
//  ConvertedValueListRow.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import SwiftUI

struct ConvertedValueListRow: View {
  let convertedCurrency: ConvertedCurrency
  let isLastRow: Bool

  var body: some View {
    VStack(alignment: .leading){
      VStack(alignment: .leading) {
        Text(convertedCurrency.currency.code)
          .font(.title2)
        Text(convertedCurrency.convertedAmount.description)
          .font(.subheadline)
      }
      .foregroundStyle(Color.gray)
      .padding(.leading, 24)
      .padding(.top, 10)
      rowDivider
    }
    
  }
  
  private var rowDivider: some View {
    Rectangle()
        .foregroundColor(Color.gray)
        .frame(height: isLastRow ? 0 : 0.5)
        .padding(.horizontal, 12)
  }
}

#Preview {
    ConvertedValueListRow(
      convertedCurrency: .preview(),
      isLastRow: false
    )
}
