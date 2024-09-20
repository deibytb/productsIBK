//
//  Product.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let images: [String]
}

struct Category: Codable {
    let id: Int
    let name: String
    let image: String
}
