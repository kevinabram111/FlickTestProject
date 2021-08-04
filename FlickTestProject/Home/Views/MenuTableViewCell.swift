//
//  MenuTableViewCell.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 04/08/21.
//

import UIKit

protocol MenuTableViewCellDelegate {
  func didTapButton(row: Int, quantity: Int)
}

class MenuTableViewCell: UITableViewCell {
  
  var delegate: MenuTableViewCellDelegate?
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var menuImageView: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var addQuantityButton: UIButton!
  @IBOutlet weak var minusQuantityButton: UIButton!
  @IBOutlet weak var quantityLabel: UILabel!
  
  @IBAction func addButtonTapped(_ sender: UIButton) {
    quantity = 1
    delegate?.didTapButton(row: row, quantity: quantity)
  }
  
  @IBAction func addQuantityButtonTapped(_ sender: UIButton) {
    if quantity < 99 {
      quantity = quantity + 1
      delegate?.didTapButton(row: row, quantity: quantity)
    }
  }
  
  @IBAction func minusQuantityButtonTapped(_ sender: UIButton) {
    quantity = quantity - 1
    delegate?.didTapButton(row: row, quantity: quantity)
  }
  
  var row: Int = 0
  
  var quantity = 0 {
    didSet {
      if quantity > 0 {
        if addButton.isHidden == false && addQuantityButton.isHidden == true && minusQuantityButton.isHidden == true && quantityLabel.isHidden == true {
          addButton.isHidden = true
          addQuantityButton.isHidden = false
          minusQuantityButton.isHidden = false
          quantityLabel.isHidden = false
        }
        quantityLabel.text = "\(quantity)"
      } else {
        if addButton.isHidden == true && addQuantityButton.isHidden == false && minusQuantityButton.isHidden == false && quantityLabel.isHidden == false {
          addButton.isHidden = false
          addQuantityButton.isHidden = true
          minusQuantityButton.isHidden = true
          quantityLabel.isHidden = true
        }
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    menuImageView.layer.cornerRadius = 10
    
    addButton.setTitleFont(text: "Tambah", fontColor: .white, font: .boldSystemFont(ofSize: 14))
    addButton.backgroundColor = .red
    addButton.layer.cornerRadius = 17.5
    
    addQuantityButton.setTitleFont(text: "+", fontColor: .white, font: .boldSystemFont(ofSize: 16))
    addQuantityButton.backgroundColor = .red
    addQuantityButton.layer.cornerRadius = 17.5
    
    minusQuantityButton.setTitleFont(text: "-", fontColor: .white, font: .boldSystemFont(ofSize: 16))
    minusQuantityButton.backgroundColor = .red
    minusQuantityButton.layer.cornerRadius = 17.5
    
    quantityLabel.font = .boldSystemFont(ofSize: 14)
    quantityLabel.text = "\(quantity)"
  }
}
