//
//  Customers.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 01/05/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Foundation
struct Customers: Decodable {
    let id: String
    let accountNumber: String
    let fullName: String
    var orders: [Order]?
}
