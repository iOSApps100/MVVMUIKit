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
}

// For each module we need to handle like this one
enum EndPointItems {
    case products
}

extension EndPointItems: EndPointType {
    var path: String {
        switch self {
        case .products:
            return "products"
        }
    }
    
    var baseURL: String {
        return "https://fakestoreapi.com/"
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        }
    }
}
