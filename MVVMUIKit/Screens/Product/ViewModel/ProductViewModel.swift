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
        APIManager.shared.fetchProducts { response in
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
}

extension ProductViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
