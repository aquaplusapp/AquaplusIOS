//
//  Cooler.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 28/08/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Foundation

struct Cooler: Decodable {
    let id: String
    let serialNumber: String
    let make: String
    let model: String
    let coolerType: String
    let status: String
    let imageURL: String
    let notes: String
    let customers: Customers
   
}
