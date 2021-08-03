//
//  CategoryCollectionViewCell.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
  
  var isEnabled: Bool = false {
    didSet {
      if isEnabled {
        lineView.isHidden = false
      } else {
        lineView.isHidden = true
      }
    }
  }
  @IBOutlet weak var categoryButton: UIButton!
  @IBOutlet weak var lineView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    lineView.layer.cornerRadius = 5
  }
  
//  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//    setNeedsLayout()
//    layoutIfNeeded()
//    let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//    var newFrame = layoutAttributes.frame
//    newFrame.size.width = CGFloat(ceilf(Float(size.width)))
//    layoutAttributes.frame = newFrame
//    
//    return layoutAttributes
//  }
}
