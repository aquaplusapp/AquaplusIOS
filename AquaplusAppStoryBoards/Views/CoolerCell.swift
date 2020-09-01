//
//  CoolerCell.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 28/08/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

class CoolerCell: UITableViewCell {

    private var cooler: Cooler?
    
    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var make: UILabel!
    @IBOutlet weak var model: UILabel!
    
    func configure(with cooler: Cooler) {
        self.cooler = cooler
        serialNumber.text = cooler.serialNumber
        make.text = cooler.make
        model.text = cooler.model
        
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
