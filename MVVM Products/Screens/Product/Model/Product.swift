//
//  Product.swift
//  MVVM Products
//
//  Created by XP India on 18/10/23.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Float
    let description: String
    let category: String
    let image: String
    let rating: Rate
}

struct Rate: Codable {
    let rate: Float
    let count: Int
}
