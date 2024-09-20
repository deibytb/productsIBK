//
//  ProductRepository.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import Foundation

class ProductRepository {
    
    private let apiService = APIService()
    
    func fetchProducts(offset: Int, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        let endpoint = APIService.Endpoint.products(offset: offset, limit: limit)
        apiService.fetchData(from: endpoint, completion: completion)
    }
    
    func fetchProductDetail(productId: Int, completion: @escaping (Result<Product, Error>) -> Void) {
        let endpoint = APIService.Endpoint.productDetail(productId: productId)
        apiService.fetchData(from: endpoint, completion: completion)
    }
}
