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
}

class HomeViewController: UIViewController {
  
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var categoryCollectionView: UICollectionView!
  
  var categoryData: [Category] = [
    .init(name: "Western"),
    .init(name: "Eastern"),
    .init(name: "Indonesian"),
    .init(name: "Japanese")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startButton.layer.backgroundColor = UIColor.white.cgColor
    startButton.layer.cornerRadius = 10
    startButton.setTitleFont(text: "Get Started", fontColor: .black)
    startButton.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
    
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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    navigationItem.title = "Flick"
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  init() {
    super.init(nibName: "HomeViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Extensions

extension HomeViewController {
  @objc func tapStartButton() {
    print("do something in here")
    
    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut) {
      self.startButton.backgroundColor = .init(white: 1, alpha: 0.5)
    } completion: { Bool in
      // MARK: - Open an alert sth here
      //      let vc = VisionViewController()
      //      self.navigationController?.pushViewController(vc, animated: true)
      
      UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn) {
        self.startButton.backgroundColor = .init(white: 1, alpha: 1)
      } completion: { Bool in
        print("success")
      }
    }
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categoryData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.categoryButton.setTitleFont(text: categoryData[indexPath.row].name, fontColor: .black)
    cell.isEnabled = categoryData[indexPath.row].isSelected
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    refreshCategories()
    categoryData[indexPath.row].isSelected = true
    categoryCollectionView.reloadData()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 1, height: 100)
  }
  
  private func refreshCategories() {
    categoryData = [
      .init(name: "Western"),
      .init(name: "Eastern"),
      .init(name: "Indonesian"),
      .init(name: "Japanese")
    ]
  }
}
