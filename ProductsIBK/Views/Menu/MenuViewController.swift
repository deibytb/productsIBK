//
//  MenuViewController.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 19/09/24.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak private var colorWell: UIColorWell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupColorWell()
    }
    
    private func setupColorWell() {
        if let savedColorData = UserDefaults.standard.data(forKey: "tabBarColor"), 
            let savedColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: savedColorData) {
            colorWell.selectedColor = savedColor
        }
        
        self.colorWell.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
    }
    
    @objc private func colorChanged(_ sender: UIColorWell) {
        guard let selectedColor = sender.selectedColor else { return }
        
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.updateTabBarColor(to: selectedColor)
        }
        self.saveColor(selectedColor)
    }
    
    private func saveColor(_ color: UIColor) {
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) {
            UserDefaults.standard.set(colorData, forKey: "tabBarColor")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
