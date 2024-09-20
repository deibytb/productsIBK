//
//  MenuViewModel.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import UIKit

class MenuViewModel {
    
    func loadSavedColor() -> UIColor? {
        return ThemeStorage.shared.loadColor(forKey: .tabBarColor)
    }
    
    func saveColor(_ color: UIColor) {
        ThemeStorage.shared.saveColor(color, forKey: .tabBarColor)
    }
    
}
