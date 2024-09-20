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
            self.updateNavBarColor(to: savedColor)
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
    
    func updateNavBarColor(to backgroundColor: UIColor, tintColor: UIColor = .white) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
        
        guard let viewControllers = self.viewControllers else { return }
        
        for viewController in viewControllers {
            if let navController = viewController as? UINavigationController {
                navController.navigationBar.standardAppearance = appearance
                navController.navigationBar.scrollEdgeAppearance = appearance
                navController.navigationBar.compactAppearance = appearance
                navController.navigationBar.isTranslucent = false
                navController.navigationBar.tintColor = tintColor
            }
        }
    }
}
