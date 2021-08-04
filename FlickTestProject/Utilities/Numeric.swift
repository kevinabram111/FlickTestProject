//
//  Numeric.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 04/08/21.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
