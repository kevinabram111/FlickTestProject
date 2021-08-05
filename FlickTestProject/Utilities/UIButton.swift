//
//  UIButton.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit

extension UIButton {
  /// Set the button's title font and text
  func setTitleFont(text: String, fontColor: UIColor, font: UIFont = UIFont.mediumApplicationFont(withSize: 20), state: UIControl.State = .normal) {
    let attrString = NSMutableAttributedString(string: text)
    attrString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, text.count))
    attrString.addAttribute(.foregroundColor, value: fontColor, range: NSMakeRange(0, text.count))
    self.setAttributedTitle(attrString, for:  state)
  }
}
