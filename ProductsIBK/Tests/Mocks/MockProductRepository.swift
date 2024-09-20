//
//  MockProductRepository.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import Foundation
//@testable import ProductsIBK

class MockProductRepository: ProductRepository {
    
    var mockResult: Result<[Product], Error>?
    
    override func fetchProducts(offset: Int, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
}
