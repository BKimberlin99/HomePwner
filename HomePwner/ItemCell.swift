//
//  ItemCell.swift
//  HomePwner
//
//  Created by Brandon Kimberlin on 3/24/19.
//  Copyright © 2019 Brandon Kimberlin. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
}

//Create custom cell to have "No more items!" centered and gray
class customItemCell: UITableViewCell {
    @IBOutlet var noItemsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        noItemsLabel.adjustsFontForContentSizeCategory = true
    }
}


