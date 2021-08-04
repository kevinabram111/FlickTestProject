//
//  HomeViewController.swift
//  Tastor
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit

struct Category {
  var name: String
  var isSelected: Bool = false
  var menuList: [Menu]
  var total: Int
  var totalPrice: Int
}

struct Menu {
  var name: String
  var description: String = ""
  var quantity: Int = 1
  var price: Int = 10000
}

class HomeViewController: UIViewController {
  
  @IBOutlet weak var categoryCollectionView: UICollectionView!
  @IBOutlet weak var menuTableView: UITableView!
  
  var categoryData: [Category] = [
    .init(name: "Korean", isSelected: true, menuList: [
      .init(name: "Korean Name", quantity: 1),
      .init(name: "Korean Name", quantity: 0),
      .init(name: "Korean Name", quantity: 3),
      .init(name: "Korean Name", quantity: 0)
    ],
          total: 4,
          totalPrice: 40000
         ),
    .init(name: "Japanese", isSelected: false, menuList: [
      .init(name: "Japanese Name", quantity: 1),
      .init(name: "Japanese Name", quantity: 0),
      .init(name: "Japanese Name", quantity: 3),
      .init(name: "Japanese Name", quantity: 0)
    ],
          total: 4,
          totalPrice: 40000
         ),
    .init(name: "Chinese", isSelected: false, menuList: [
      .init(name: "Chinese Name", quantity: 1),
      .init(name: "Chinese Name", quantity: 0),
      .init(name: "Chinese Name", quantity: 3),
      .init(name: "Chinese Name", quantity: 0)
    ],
          total: 4,
          totalPrice: 40000
         ),
    .init(name: "Indonesian", isSelected: false, menuList: [
      .init(name: "Indonesian Name", quantity: 1),
      .init(name: "Indonesian Name", quantity: 0),
      .init(name: "Indonesian Name", quantity: 3),
      .init(name: "Indonesian Name", quantity: 0)
    ],
          total: 4,
          totalPrice: 40000
         ),
    .init(name: "American", isSelected: false, menuList: [
      .init(name: "American Name", quantity: 1),
      .init(name: "American Name", quantity: 0),
      .init(name: "American Name", quantity: 3),
      .init(name: "American Name", quantity: 0)
    ],
          total: 4,
          totalPrice: 40000
         )
  ]
  
  var selectedCategoryIndex = 0 {
    didSet {
      /// Perform changes in collection view
      refreshCategories()
      categoryData[selectedCategoryIndex].isSelected = true
      categoryCollectionView.reloadData()
      
      /// Perform changes in table view
      menuTableView.tableHeaderView = constructTableHeaderView()
      menuTableView.reloadData()
    }
  }
  
  /// Table header view that is shown on top of the tableview
  /// I created it programmatically instead of creating xibs to save space
  func constructTableHeaderView() -> UIView {
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    for _ in categoryData {
      categoryData[index].isSelected = false
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
    categoryData[selectedCategoryIndex].menuList[row].quantity = quantity
    
    /// Update the total qty and total price on the selected category
    let totalSelectedCategory = categoryData.reduce(0, {$0 + $1.menuList[row].quantity})
    categoryData[selectedCategoryIndex].total = totalSelectedCategory
    let totalSelectedPriceCategory = categoryData.reduce(0, {$0 + ($1.menuList[row].price * $1.menuList[row].quantity)})
    categoryData[selectedCategoryIndex].totalPrice = totalSelectedPriceCategory
    
    /// Get the total on all categories
    let totalAll = categoryData.reduce(0, {$0 + $1.total})
    let totalPriceAll = categoryData.reduce(0, {$0 + $1.totalPrice})
    print(totalAll)
    print(totalPriceAll)
  }
}
