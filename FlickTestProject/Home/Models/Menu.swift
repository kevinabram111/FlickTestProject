//
//  Menu.swift
//  FlickTestProject
//
//  Created by Kevin Abram on 05/08/21.
//

import Foundation
import RealmSwift

/// Menu object, to be shown on the table view
class Menu: Object {
  @objc dynamic var name: String = ""
  @objc dynamic var menuDescription: String = ""
  @objc dynamic var quantity: Int = 0
  @objc dynamic var price: Int = 10000
}
