//
//  UITableView.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit

extension UITableView {
  
  /// Register the UITableViewCell if it uses xib
  @discardableResult
  func registerReusableCellNib<T: UITableViewCell>(
    _ cellClass: T.Type,
    withIdentifier identifier: String = T.reuseIdentifier
  ) -> UITableView {
    let nib = UINib(nibName: identifier, bundle: nil)
    register(nib, forCellReuseIdentifier: identifier)
    return self
  }
  
  /// Register the UITableViewCell if it is made programmatically (not use xib)
  @discardableResult
  func registerReusableCellClass<T: UITableViewCell>(
    _ cellClass: T.Type,
    withIdentifier identifier: String = T.reuseIdentifier
  ) -> UITableView {
    register(cellClass, forCellReuseIdentifier: identifier)
    return self
  }
  
  func dequeueReusableCell<T: UITableViewCell>(
    withIdentifier identifier: String = T.reuseIdentifier,
    for indexPath: IndexPath
  ) -> T {
    return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T ?? T()
  }
}
