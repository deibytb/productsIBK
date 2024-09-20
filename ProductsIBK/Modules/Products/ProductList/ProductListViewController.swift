//
//  ProductListViewController.swift
//  ProductsIBK
//
//  Created by Deiby Toralva on 20/09/24.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let viewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Productos"
        self.setupTableView()
        self.loadProducts()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
    }
    
    private func loadProducts() {
        viewModel.fetchProducts { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func showProductDetail(for product: Product) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            detailVC.product = product
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        let product = viewModel.products[indexPath.row]
        cell.textLabel?.text = product.title
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = viewModel.products[indexPath.row]
        showProductDetail(for: selectedProduct)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.products.count - 1 && viewModel.hasMoreProducts {
            loadProducts()
        }
    }
}
