//
//  HomeViewController.swift
//  Tastor
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit
import RealmSwift

class Category: Object {
  @objc dynamic var name: String = ""
  @objc dynamic var isSelected: Bool = false
  var menuList = List<Menu>()
  @objc dynamic var total: Int = 0
  @objc dynamic var totalPrice: Int = 0
}

class Menu: Object {
  @objc dynamic var name: String = ""
  @objc dynamic var menuDescription: String = ""
  @objc dynamic var quantity: Int = 0
  @objc dynamic var price: Int = 10000
}

class HomeViewController: UIViewController {
  
  @IBOutlet weak var categoryCollectionView: UICollectionView!
  @IBOutlet weak var menuTableView: UITableView!
  
  @IBOutlet weak var cartView: UIView!
  
  @IBOutlet weak var quantityContainerView: UIView!
  
  @IBOutlet weak var quantityLabel: UILabel!
  
  @IBOutlet weak var priceLabel: UILabel!
  
  var categoryData: [Category] = []
  
  /// A flag to control whether the app has been loaded fully
  var isInitialized: Bool = false
  
  var selectedCategoryIndex = 0 {
    didSet {
      /// Perform changes in collection view
      refreshCategories()
      let realm = try! Realm()
      try! realm.write {
        categoryData[selectedCategoryIndex].isSelected = true
      }
      categoryCollectionView.reloadData()
      
      /// Perform changes in table view
      menuTableView.tableHeaderView = constructTableHeaderView()
      menuTableView.reloadData()
      if categoryData[selectedCategoryIndex].menuList.count != 0 && isInitialized == true {
        menuTableView.scrollToRow(at: .init(row: 0, section: 0), at: .bottom, animated: true)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    /// Initialize Data
    initialize()
    
    /// Initialize Collection View
    categoryCollectionView.delegate = self
    categoryCollectionView.dataSource = self
    categoryCollectionView.registerReusableCellNib(CategoryCollectionViewCell.self)
    
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.scrollDirection = .horizontal
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    
    categoryCollectionView.collectionViewLayout = layout
    categoryCollectionView.backgroundColor = .clear
    categoryCollectionView.showsHorizontalScrollIndicator = false
    
    /// Initialize Table View
    menuTableView.delegate = self
    menuTableView.dataSource = self
    menuTableView.registerReusableCellNib(MenuTableViewCell.self)
    
    menuTableView.tableHeaderView = constructTableHeaderView()
    menuTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
    
    /// Design The Cart View
    cartView.layer.cornerRadius = 10
    quantityContainerView.layer.cornerRadius = 8
    
    /// Set the flag for initialized successfully
    isInitialized = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    navigationItem.title = "Flick"
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  init() {
    super.init(nibName: "HomeViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Functions

extension HomeViewController {
  /// Table header view that is shown on top of the tableview
  /// I created it programmatically instead of creating xibs to save space
  private func constructTableHeaderView() -> UIView {
    let tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    let headerLabel = UILabel()
    headerLabel.font = .boldApplicationFont(withSize: 16)
    headerLabel.text = categoryData[selectedCategoryIndex].name
    
    /// Setup constraints
    tableHeaderView.addSubview(headerLabel)
    NSLayoutConstraint.activate([
      headerLabel.topAnchor.constraint(equalTo: tableHeaderView.topAnchor),
      headerLabel.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 16),
      headerLabel.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: 16),
      headerLabel.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor)
    ])
    headerLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return tableHeaderView
  }
  
  /// Function to handle show or hide cart view
  private func showOrHideCartView() {
    let quantity = categoryData.reduce(0, {$0 + $1.total})
    let price = categoryData.reduce(0, {$0 + $1.totalPrice})
    if quantity > 0 || price > 0 && cartView.isHidden == false {
      cartView.isHidden = false
    } else if quantity == 0 || price == 0 && cartView.isHidden == true {
      cartView.isHidden = true
    }
    quantityLabel.text = "\(quantity)"
    priceLabel.text = "Rp. \(price.formattedWithSeparator)"
  }
  
  /// Function to initalize empty data
  private func initialize() {
    /// First check the data if the data exists
    let realm = try! Realm()
    let results = realm.objects(Category.self)
    if results.count == 0 {
      /// Then append the data if the data does not exists
      let koreanCategory = Category()
      koreanCategory.name = "Korean"
      koreanCategory.isSelected = true
      koreanCategory.total = 10
      koreanCategory.totalPrice = 100000
      
      let koreanMenu1 = Menu()
      koreanMenu1.name = "Bibimbap"
      koreanMenu1.quantity = 5
      
      let koreanMenu2 = Menu()
      koreanMenu2.name = "Kimchi"
      koreanMenu2.quantity = 4
      
      let koreanMenu3 = Menu()
      koreanMenu3.name = "Japchae"
      koreanMenu3.quantity = 1
      
      koreanCategory.menuList.append(koreanMenu1)
      koreanCategory.menuList.append(koreanMenu2)
      koreanCategory.menuList.append(koreanMenu3)
      
      let japaneseCategory = Category()
      japaneseCategory.name = "Japanese"
      japaneseCategory.isSelected = false
      japaneseCategory.total = 1
      japaneseCategory.totalPrice = 10000
      
      let japaneseMenu1 = Menu()
      japaneseMenu1.name = "Sushi"
      japaneseMenu1.quantity = 1
      
      let japaneseMenu2 = Menu()
      japaneseMenu2.name = "Sashimi"
      
      let japanesemenu3 = Menu()
      japanesemenu3.name = "Udon"
      
      let japaneseMenu4 = Menu()
      japaneseMenu4.name = "Ramen"
      
      japaneseCategory.menuList.append(japaneseMenu1)
      japaneseCategory.menuList.append(japaneseMenu2)
      japaneseCategory.menuList.append(japanesemenu3)
      japaneseCategory.menuList.append(japaneseMenu4)
      
      let chineseCategory = Category()
      chineseCategory.name = "Chinese"
      chineseCategory.isSelected = false
      
      let chineseMenu1 = Menu()
      chineseMenu1.name = "Lo Mie"
      
      chineseCategory.menuList.append(chineseMenu1)
      
      let indonesianCategory = Category()
      indonesianCategory.name = "Indonesian"
      
      let indonesianMenu1 = Menu()
      indonesianMenu1.name = "Soto Ayam"
      
      let indonesianMenu2 = Menu()
      indonesianMenu2.name = "Pecel"
      
      let indonesianMenu3 = Menu()
      indonesianMenu3.name = "Soto Betawi"
      
      let indonesianMenu4 = Menu()
      indonesianMenu4.name = "Rawon"
      
      let indonesianMenu5 = Menu()
      indonesianMenu5.name = "Sate Ayam"
      
      let indonesianMenu6 = Menu()
      indonesianMenu6.name = "Sate Kambing"
      
      indonesianCategory.menuList.append(indonesianMenu1)
      indonesianCategory.menuList.append(indonesianMenu2)
      indonesianCategory.menuList.append(indonesianMenu3)
      indonesianCategory.menuList.append(indonesianMenu4)
      indonesianCategory.menuList.append(indonesianMenu5)
      indonesianCategory.menuList.append(indonesianMenu6)
      
      let americanCategory = Category()
      americanCategory.name = "American"
      
      let americanMenu1 = Menu()
      americanMenu1.name = "Steak"
      
      americanCategory.menuList.append(americanMenu1)
      
      /// Append the initialized data to the local realm database
      try! realm.write {
        realm.add(koreanCategory)
        realm.add(japaneseCategory)
        realm.add(chineseCategory)
        realm.add(indonesianCategory)
        realm.add(americanCategory)
      }
    }
    categoryData = Array(results)
    /// Get the active index
    var startIndex = 0
    for index in categoryData {
      if index.isSelected == true {
        selectedCategoryIndex = startIndex
      }
      startIndex = startIndex + 1
    }
    showOrHideCartView()
  }
}

// MARK: - UICollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categoryData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.categoryButton.setTitleFont(text: categoryData[indexPath.row].name, fontColor: .black, font: .boldSystemFont(ofSize: 14))
    cell.isEnabled = categoryData[indexPath.row].isSelected
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedCategoryIndex = indexPath.row
  }
  
  func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 1, height: 40)
  }
  
  private func refreshCategories() {
    var index = 0
    let realm = try! Realm()
    for _ in categoryData {
      try! realm.write {
        categoryData[index].isSelected = false
      }
      index = index + 1
    }
  }
}

// MARK: - UITableView

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryData[selectedCategoryIndex].menuList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: MenuTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.setupData(
      delegate: self,
      row: indexPath.row,
      menu: categoryData[selectedCategoryIndex].menuList[indexPath.row]
    )
    return cell
  }
}

// MARK: - MenuTableViewCellDelegate

extension HomeViewController: MenuTableViewCellDelegate {
  func didTapButton(row: Int, quantity: Int) {
    let realm = try! Realm()
    try! realm.write {
    categoryData[selectedCategoryIndex].menuList[row].quantity = quantity
    
    /// Update the total qty and total price on the selected category
    let totalSelectedCategory = categoryData[selectedCategoryIndex].menuList.reduce(0, {$0 + ($1.quantity)})
    categoryData[selectedCategoryIndex].total = totalSelectedCategory
    let totalSelectedPriceCategory = categoryData[selectedCategoryIndex].menuList.reduce(0, {$0 + ($1.quantity * $1.price)})
    categoryData[selectedCategoryIndex].totalPrice = totalSelectedPriceCategory
    }
    
    /// Show or hide cart view
    showOrHideCartView()
  }
}
