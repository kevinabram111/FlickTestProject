//
//  UIFont.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit

extension UIFont {
  class func applicationFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: "Poppins-Regular", size: size) else {
      return UIFont.systemFont(ofSize: size)
    }
    return font
  }
  
  class func boldApplicationFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: "Poppins-Bold", size: size) else {
      return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    return font
  }
  
  class func mediumApplicationFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: "Poppins-Medium", size: size) else {
      return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    return font
  }
  
  class func semiBoldApplicationFont(withSize size: CGFloat) -> UIFont {
    guard let font = UIFont(name: "Poppins-SemiBold", size: size) else {
      return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    return font
  }
}
