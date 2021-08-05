//
//  Category.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 05/08/21.
//

import Foundation
import RealmSwift

/// Category object, to be shown on the collection view
class Category: Object {
  @objc dynamic var name: String = ""
  @objc dynamic var isSelected: Bool = false
  var menuList = List<Menu>()
  @objc dynamic var total: Int = 0
  @objc dynamic var totalPrice: Int = 0
}
