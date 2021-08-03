//
//  UIButton.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit

extension UIButton {
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
  
  /// Customize the button's title font and text
  func setTitleFont(text: String, fontColor: UIColor, font: UIFont = mediumApplicationFont(withSize: 20), state: UIControl.State = .normal) {
    let attrString = NSMutableAttributedString(string: text)
    attrString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, text.count))
    attrString.addAttribute(.foregroundColor, value: fontColor, range: NSMakeRange(0, text.count))
    self.setAttributedTitle(attrString, for:  state)
  }
}
