//
//  APIService.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import Foundation

class APIService {
    
    enum Endpoint {
        case products(offset: Int, limit: Int)
        case productDetail(productId: Int)
        
        var url: URL? {
            switch self {
            case .products(let offset, let limit):
                return URL(string: "https://api.escuelajs.co/api/v1/products?offset=\(offset)&limit=\(limit)")
            case .productDetail(let productId):
                return URL(string: "https://api.escuelajs.co/api/v1/products/\(productId)")
            }
        }
    }
    
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endpoint.url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}
