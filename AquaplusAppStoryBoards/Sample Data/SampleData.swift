//
//  SampleData.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 27/08/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Foundation

final class SampleData {

    static func generateProductsData() -> [ProductsSample] {
        return [
            ProductsSample(productCode: "WATER", product: "18.9 Natural Mineral Water", price: 100),
            ProductsSample(productCode: "750STILL", product: "750ml Still", price: 8),
            ProductsSample(productCode: "750SPK", product: "750ml Sparkling", price: 8)
        ]
        
        
    }
    
}
