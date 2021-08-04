//
//  Formatter.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 04/08/21.
//

import Foundation

extension Formatter {
  static let withSeparator: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = ","
    return formatter
  }()
}
