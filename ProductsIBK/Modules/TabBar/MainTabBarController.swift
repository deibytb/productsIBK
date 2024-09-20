//
//  MainTabBarController.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 19/09/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let viewModel = MainTabBarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadSavedTheme()
    }
    
    private func loadSavedTheme() {
        if let savedColor = viewModel.loadSavedTabBarColor() {
            self.updateTabBarColor(to: savedColor)
        }
    }
}

extension MainTabBarController {
    func updateTabBarColor(to backgroundColor: UIColor, tintColor: UIColor = .white) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.tabBar.tintColor = tintColor
    }
}
