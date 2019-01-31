//
//  TableCell.swift
//  Life Counter
//
//  Created by Phillip Park on 1/29/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var minOne: UIButton!
    
    @IBOutlet weak var player: UILabel!
    
    @IBOutlet weak var lifePoint: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
