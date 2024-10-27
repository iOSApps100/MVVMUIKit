//
//  EndPointType.swift
//  MVVMUIKit
//
//  Created by Vivek  Garg on 21/10/24.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String {get}
    var baseURL: String {get}
    var url: URL? {get}
    var method: HTTPMethods {get}
    var body: Encodable? {get}
    var headers: [String: String]? {get}
}

// For each module we need to handle like this one
enum EndPointItems {
    case products
    case addProduct(product: AddProduct)
}

extension EndPointItems: EndPointType {
    
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case .addProduct:
            return "products/add"
        }
    }
    
    var baseURL: String {
        switch self {
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://dummyjson.com/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }
    
    var body: Encodable? {
        switch self {
        case .products: 
            return nil
        case .addProduct(let product):
            return product
        }
    }
    
    var headers: [String : String]? {
        return APIManager.commonHeaders
    }
}
