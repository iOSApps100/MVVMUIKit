//
//  Product.swift
//  MVVMUIKit
//
//  Created by Vivek  Garg on 19/10/24.
//

import Foundation

struct Product: Codable {
    let  id: Int
    let  title: String
    let  price: Double
    let  description: String
    let  category: String
    let  image: String
    let  rating: Rate
    
}

struct Rate: Codable {
    let rate: Double
    let count: Int
}
