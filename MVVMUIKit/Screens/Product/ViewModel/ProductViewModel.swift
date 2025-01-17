//
//  ProductViewModel.swift
//  MVVMUIKit
//
//  Created by Vivek  Garg on 19/10/24.
//

import Foundation

final class ProductViewModel {
    
    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    
    func fetchProducts() {
        eventHandler?(.loading)
        APIManager.shared.request(modelType: [Product].self, type: EndPointItems.products) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func addProduct(parameters: AddProduct) {
        APIManager.shared.request(modelType: AddProduct.self, type: EndPointItems.addProduct(product: parameters)) { result in
            switch result {
            case .success(let product):
                self.eventHandler?(.newProductAdded(product: product))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
//    func fetchProducts() {
//        eventHandler?(.loading)
//        APIManager.shared.fetchProducts { response in
//            self.eventHandler?(.stopLoading)
//            switch response {
//            case .success(let products):
//                self.products = products
//                self.eventHandler?(.dataLoaded)
//            case .failure(let error):
//                print(error)
//                self.eventHandler?(.error(error))
//            }
//        }
//
//    }
}

extension ProductViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newProductAdded(product: AddProduct)
    }
}
