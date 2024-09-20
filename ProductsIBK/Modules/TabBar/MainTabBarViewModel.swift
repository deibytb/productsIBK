//
//  MainTabBarViewModel.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import UIKit

class MainTabBarViewModel {
    
    func loadSavedTabBarColor() -> UIColor? {
        return ThemeStorage.shared.loadColor(forKey: .tabBarColor)
    }
    
}
