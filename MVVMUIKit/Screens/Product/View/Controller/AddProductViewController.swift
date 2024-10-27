//
//  AddProductViewController.swift
//  MVVMUIKit
//
//  Created by Vivek  Garg on 25/10/24.
//

import UIKit

struct AddProduct: Codable {
    
    let title: String
}

struct ProductResponse: Decodable {
    
    let id: Int
    let title: String
}

class AddProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addProduct()
    }

    func addProduct() {
        guard let url = URL(string: "https://dummyjson.com/products/add") else {return}
        let parameters = AddProduct(title: "BMW car")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // need to convert Model into Data
        request.httpBody = try? JSONEncoder().encode(parameters)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                return
            }
            
            do {
                // Data to Model convert
                let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                print(productResponse)
            } catch {
                print(error)
            }
        }.resume()
    }
}
