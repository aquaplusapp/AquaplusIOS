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
    let accountName: String
    let fullName: String
    let emailAddress: String
    let telephone: String
    let address1: String
    let address2: String
    let town: String
    let county: String
    let postCode: String
    var orders: [Order]?
    var cooler: [Cooler]?
}


