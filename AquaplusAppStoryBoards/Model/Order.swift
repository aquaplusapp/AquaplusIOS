//
//  Order.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 01/05/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Foundation

struct Order: Decodable {
    let id: String
    let quantityBottles: Int
    let emptyBottles: Int
    let createdAt: Double
    let notes: String
    var fromnow: String?
    let customers: Customers
    let dateOrdered: String
}
