//
//  RefreshButton.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import SwiftUI

struct RefreshButton: View {
  @ObservedObject var viewModel: ContentViewModel
  
  var body: some View {
    VStack(spacing: 5.0) {
      Button(
        action: {
          Task {
            await viewModel.fetch()
          }
        },
        label: {
          Image(systemName: "arrow.clockwise")
            .font(.system(size: 30))
            .foregroundColor(Color.accentColor)
        }
      )

      Text("Tap to refresh")
        .foregroundStyle(Color.white)
    }
  }
}

#Preview {
  RefreshButton(
    viewModel: .preview()
  )
  .frame(width: 500, height: 500)
  .background(Color.black)
}
