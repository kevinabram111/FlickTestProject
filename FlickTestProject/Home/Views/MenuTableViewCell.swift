//
//  MenuTableViewCell.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 04/08/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var menuImageView: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var addButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    menuImageView.layer.cornerRadius = 10
    
    addButton.setTitleFont(text: "Tambah", fontColor: .white, font: .boldSystemFont(ofSize: 12))
    addButton.backgroundColor = .red
    addButton.layer.cornerRadius = 15
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
