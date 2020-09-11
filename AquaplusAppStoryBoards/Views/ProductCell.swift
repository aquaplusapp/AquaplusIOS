//
//  ProductCell.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 26/08/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
   private var product: Product?
    //MARK: - IBOutlets
    @IBOutlet weak var productCodeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    func configure(with product: Product) {
        self.product = product
        productCodeLabel.text = product.productCode
        descriptionLabel.text = product.product
        priceLabel.text = String(product.price)
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
