//
//  TableCell.swift
//  LifeCounter
//
//  Created by Phillip Park on 1/31/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var lifePoint: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var history: UILabel!
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
   

}
