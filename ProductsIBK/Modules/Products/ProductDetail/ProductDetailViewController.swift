//
//  ProductDetailViewController.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        guard let product = self.product else { return }
        
        self.title = product.title
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        imageView.loadImage(from: product.images.first)
    }
}
