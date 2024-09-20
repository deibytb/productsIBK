//
//  ThemeStorage.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import UIKit

class ThemeStorage {
    
    static let shared = ThemeStorage()
    
    func saveColor(_ color: UIColor, forKey key: ThemeKey) {
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) {
            UserDefaults.standard.set(colorData, forKey: key.rawValue)
        }
    }
    
    func loadColor(forKey key: ThemeKey) -> UIColor? {
        if let savedColorData = UserDefaults.standard.data(forKey: key.rawValue),
           let savedColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: savedColorData) {
            return savedColor
        }
        return nil
    }
}

extension ThemeStorage {
    enum ThemeKey: String {
        case tabBarColor
    }
}
