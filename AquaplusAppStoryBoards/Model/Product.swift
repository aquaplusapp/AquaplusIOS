//
//  Product.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 01/09/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let id: String
    let productCode: String
    let product: String
    let price: Double
    let deposit: Double
    let productType: String
    let nominal: String
    let taxCode: String
    //let order: Order
   
}
