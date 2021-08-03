//
//  UICollectionView.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit

extension UICollectionView {
  
  /// Register the UICollectionViewCell if it uses xib
  @discardableResult
  func registerReusableCellNib<T: UICollectionViewCell>(
    _ cellClass: T.Type,
    withIdentifier identifier: String = T.reuseIdentifier
  ) -> UICollectionView {
    let nib = UINib(nibName: identifier, bundle: nil)
    register(nib, forCellWithReuseIdentifier: identifier)
    return self
  }
  
  /// Register the UICollectionViewCell if it is made programmatically (not use xib)
  @discardableResult
  func registerReusableCellClass<T: UICollectionViewCell>(
    _ cellClass: T.Type,
    withIdentifier identifier: String = T.reuseIdentifier
  ) -> UICollectionView {
    register(cellClass, forCellWithReuseIdentifier: identifier)
    return self
  }
  
  func dequeueReusableCell<T: UICollectionViewCell>(
    withReuseIdentifier identifier: String = T.defaultReuseIdentifier(),
    for indexPath: IndexPath
  ) -> T {
    return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T ?? T()
  }
}

extension UICollectionReusableView {
  @objc class func defaultReuseIdentifier() -> String {
    return String(describing: self)
  }
}
