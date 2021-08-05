//
//  AppDelegate.swift
//  Tastor
//
//  Created by Kevin Abram on 22/07/21.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    compactRealm()
    let navigationController: UINavigationController?
    navigationController = UINavigationController(rootViewController: HomeViewController())
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
  
  func compactRealm() {
    let defaultURL = Realm.Configuration.defaultConfiguration.fileURL!
    let defaultParentURL = defaultURL.deletingLastPathComponent()
    let compactedURL = defaultParentURL.appendingPathComponent("default-compact.realm")
    
    autoreleasepool {
      let realm = try! Realm()
      try! realm.writeCopy(toFile: compactedURL)
    }
    try! FileManager.default.removeItem(at: defaultURL)
    try! FileManager.default.moveItem(at: compactedURL, to: defaultURL)
  }
}

