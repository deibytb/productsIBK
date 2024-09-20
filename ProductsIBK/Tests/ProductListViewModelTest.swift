//
//  ProductListViewModelTest.swift
//  ProductsIBKTests
//
//  Created by Deiby Toralva on 20/09/24.
//

import XCTest
@testable import ProductsIBK

final class ProductListViewModelTest: XCTestCase {
    
    var mockRepository: MockProductRepository!
    var viewModel: ProductListViewModel!
    
    override func setUp() {
        super.setUp()
        
        mockRepository = MockProductRepository()
        viewModel = ProductListViewModel(productRepository: mockRepository, limit: 2)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        
        super.tearDown()
    }
    
    // Prueba de éxito en la carga de productos
    func testFetchProductsSuccess() {
        let products = [
            Product(id: 1, title: "Product 1", price: 100.0, description: "Description 1", category: Category(id: 1, name: "Category 1", image: ""), images: [""]),
            Product(id: 2, title: "Product 2", price: 200.0, description: "Description 2", category: Category(id: 2, name: "Category 2", image: ""), images: [""])
        ]
        mockRepository.mockResult = .success(products)
        
        let expectation = self.expectation(description: "Products fetched")
        viewModel.fetchProducts {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertEqual(viewModel.products.first?.title, "Product 1")
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertTrue(viewModel.hasMoreProducts)
    }
    
    // Prueba de paginación
    func testFetchProductsPagination() {
        // Página 1
        let productsPage1 = [
            Product(id: 1, title: "Product 1", price: 100.0, description: "Description 1", category: Category(id: 1, name: "Category 1", image: ""), images: [""]),
            Product(id: 2, title: "Product 2", price: 200.0, description: "Description 2", category: Category(id: 2, name: "Category 2", image: ""), images: [""])
        ]
        mockRepository.mockResult = .success(productsPage1)
        
        let expectation1 = self.expectation(description: "First page fetched")
        viewModel.fetchProducts {
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertEqual(viewModel.products.last?.title, "Product 2")
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertTrue(viewModel.hasMoreProducts)
        
        // Página 2
        let productsPage2 = [
            Product(id: 3, title: "Product 3", price: 300.0, description: "Description 3", category: Category(id: 3, name: "Category 3", image: ""), images: [""]),
            Product(id: 4, title: "Product 4", price: 400.0, description: "Description 4", category: Category(id: 4, name: "Category 4", image: ""), images: [""])
        ]
        mockRepository.mockResult = .success(productsPage2)
        
        let expectation2 = self.expectation(description: "Second page fetched")
        viewModel.fetchProducts {
            expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        XCTAssertEqual(viewModel.products.count, 4)
        XCTAssertEqual(viewModel.products.last?.title, "Product 4")
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertTrue(viewModel.hasMoreProducts)
        
        // Página 3
        let productsPage3 = [
            Product(id: 5, title: "Product 5", price: 300.0, description: "Description 5", category: Category(id: 5, name: "Category 5", image: ""), images: [""])
        ]
        mockRepository.mockResult = .success(productsPage3)
        
        let expectation3 = self.expectation(description: "Third page fetched")
        viewModel.fetchProducts {
            expectation3.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        XCTAssertEqual(viewModel.products.count, 5)
        XCTAssertEqual(viewModel.products.last?.title, "Product 5")
        XCTAssertEqual(viewModel.currentPage, 3)
        XCTAssertFalse(viewModel.hasMoreProducts)
    }
    
    // Prueba de manejo de errores
    func testFetchProductsFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network Error"])
        mockRepository.mockResult = .failure(error)

        let expectation = self.expectation(description: "Error fetched")
        viewModel.fetchProducts {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertEqual(viewModel.products.count, 0)
        XCTAssertEqual(viewModel.currentPage, 0)
        XCTAssertTrue(viewModel.hasMoreProducts)
    }
    
    // Prueba de no cargar productos si ya está cargando o si no hay más productos
    func testNoFetchWhenAlreadyLoadingOrNoMoreProducts() {
        // No carga de productos
        viewModel.isLoading = true

        viewModel.fetchProducts {
            // No debería hacer nada
        }

        XCTAssertEqual(viewModel.products.count, 0)
        XCTAssertEqual(viewModel.currentPage, 0)

        // Simular que no hay más productos
        viewModel.isLoading = false
        viewModel.hasMoreProducts = false

        viewModel.fetchProducts {
            // No debería hacer nada
        }

        XCTAssertEqual(viewModel.products.count, 0)
        XCTAssertEqual(viewModel.currentPage, 0)
    }
}
