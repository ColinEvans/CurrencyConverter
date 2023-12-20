//
//  ConversionListView.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import SwiftUI

struct ConversionListView: View {
  @ObservedObject var viewModel: ConversionListViewModel
  private let cornerRadius: CGFloat = 5.0

  var body: some View {
    GeometryReader { proxy in
      VStack(spacing: 0) {
        header
          .frame(height: proxy.size.height * UIConstants.headerHeightRatio)
        rows
          .background(Color.white)
        footer
          .frame(height: proxy.size.height * UIConstants.footerHeightRatio)
      }
    }
    .background(Color.clear)
  }
  
  private var header: some View {
    ZStack {
      Rectangle()
        .foregroundColor(Color.primaryBlue)
        .cornerRadius(cornerRadius, corners: [.topLeft, .topRight])
      Text("Converted Currencies")
        .font(.title)
        .foregroundStyle(Color.white)
    }
  }
  
  private var rows: some View {
    ScrollView {
      ForEach(viewModel.convertedCurrencies) { currency in
        ConvertedValueListRow(
          convertedCurrency: currency,
          isLastRow: currency == viewModel.convertedCurrencies.last
        )
      }
    }
  }
  
  private var footer: some View {
    Rectangle()
      .foregroundColor(Color.white)
      .cornerRadius(cornerRadius, corners: [.bottomLeft, .bottomRight])
  }
  
  private struct UIConstants {
    static let widthRatio: CGFloat = 0.6
    static let headerHeightRatio: CGFloat = 0.2
    static let footerHeightRatio: CGFloat = 0.05
  }
}

#Preview {
  ConversionListView(viewModel: .preview())
}
