//
//  MainTabBarController.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 19/09/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadSavedTheme()
    }
    
    func updateTabBarColor(to backgroundColor: UIColor, tintColor: UIColor = .white) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.tabBar.tintColor = UIColor.white
    }
    
    private func loadSavedTheme() {
        if let savedColorData = UserDefaults.standard.data(forKey: "tabBarColor"),
            let savedColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: savedColorData) {
            self.updateTabBarColor(to: savedColor)
        }
    }
}
