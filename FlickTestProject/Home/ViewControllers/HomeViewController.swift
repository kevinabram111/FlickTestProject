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
  var quantity: Int = 1
}

class HomeViewController: UIViewController {
  
  @IBOutlet weak var categoryCollectionView: UICollectionView!
  @IBOutlet weak var menuTableView: UITableView!
  
  var categoryData: [Category] = [
    .init(name: "Korean", isSelected: true),
    .init(name: "Japanese"),
    .init(name: "Indonesian"),
    .init(name: "Chinese"),
    .init(name: "American")
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
    categoryData = [
      .init(name: "Korean"),
      .init(name: "Japanese"),
      .init(name: "Indonesian"),
      .init(name: "Chinese"),
      .init(name: "American")
    ]
  }
}

// MARK: - UITableView

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // TODO: - Change this into a real value
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: MenuTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.quantity = 1
    return cell
  }
}
