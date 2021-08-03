//
//  Reusable.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit

// MARK: - An extension for UITableView and UICollectionView to make it cleaner

protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

extension UICollectionViewCell: Reusable {}
