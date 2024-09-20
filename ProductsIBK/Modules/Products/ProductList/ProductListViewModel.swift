//
//  ProductListViewModel.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import Foundation

class ProductListViewModel {
    
    private let productRepository: ProductRepository
    private(set) var products: [Product] = []
    private(set) var currentPage: Int = 0
    private let limit: Int
    var isLoading: Bool = false
    var hasMoreProducts: Bool = true
    
    init(productRepository: ProductRepository = ProductRepository(), limit: Int = 10) {
        self.productRepository = productRepository
        self.limit = limit
    }
    
    func fetchProducts(completion: @escaping () -> Void) {
        guard !isLoading && hasMoreProducts else { return }
        isLoading = true
        
        productRepository.fetchProducts(offset: currentPage * limit, limit: limit) { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let newProducts):
                if newProducts.count < self.limit {
                    self.hasMoreProducts = false
                }
                self.products.append(contentsOf: newProducts)
                self.currentPage += 1
                completion()
            case .failure(let error):
                print("Error fetching products: \(error.localizedDescription)")
                completion()
            }
        }
    }
}
