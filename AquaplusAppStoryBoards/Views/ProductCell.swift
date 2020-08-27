//
//  ProductCell.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 26/08/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var productCodeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK: - Properties
    var products: Products? {
        didSet {
            guard let products = products else { return }
            
            productCodeLabel.text = products.productCode
            descriptionLabel.text = products.product
            priceLabel.text = String(products.price)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
