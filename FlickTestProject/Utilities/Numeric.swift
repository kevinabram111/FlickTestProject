//
//  Numeric.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 04/08/21.
//

import Foundation

/// Used to format number into indonesian currency format
extension Numeric {
  var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
