//
//  View_CornerRadius.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-16.
//

import Foundation
import SwiftUI

extension View {
  /// View modifier that applies the radius only to the supplied corners.
  /// Corners not listed will remain unmodified
  ///
  /// - Parameters:
  ///    - radius: The corner radius value
  ///    - corners: The corners to apply the radius to
  /// - Returns: A view with the supplied corners applying the given corner radius
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}

private struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners

  func path(in rect: CGRect) -> Path {
      let path = UIBezierPath(
        roundedRect: rect,
        byRoundingCorners: corners,
        cornerRadii: CGSize(width: radius, height: radius)
      )
      return Path(path.cgPath)
  }
}
