//
//  MenuViewController.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 19/09/24.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak private var colorWell: UIColorWell!
    
    private let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupColorWell()
    }
    
    private func setupColorWell() {
        if let savedColor = viewModel.loadSavedColor() {
            colorWell.selectedColor = savedColor
        }
        
        self.colorWell.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
    }
    
    @objc private func colorChanged(_ sender: UIColorWell) {
        guard let selectedColor = sender.selectedColor else { return }
        
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.updateTabBarColor(to: selectedColor)
        }
        
        viewModel.saveColor(selectedColor)
    }
    
}
