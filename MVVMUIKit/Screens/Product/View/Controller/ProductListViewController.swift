//
//  ProductListViewController.swift
//  MVVMUIKit
//
//  Created by Vivek  Garg on 19/10/24.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    private var viewModel: ProductViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

extension ProductListViewController {
    
    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        ObserveEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    // Data binding event observor
    func ObserveEvent() {
        viewModel.eventHandler  = { [weak self] event in
            guard let self else {return}
            switch event {
            case .loading:
                print("Data Loading")
                
            case .stopLoading:
                print("Stop Loading")
            case .dataLoaded:
                print("Data Loaded")
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = self.viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}
