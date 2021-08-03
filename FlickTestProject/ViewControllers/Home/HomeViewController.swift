//
//  HomeViewController.swift
//  Tastor
//
//  Created by Kevin Abram on 03/08/21.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var startButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    startButton.layer.backgroundColor = UIColor.white.cgColor
    startButton.layer.cornerRadius = 10
    startButton.setTitleFont(text: "Get Started", fontColor: .black)
    startButton.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
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
