//
//  CustomCell.swift
//  Test
//
//  Created by Admin on 4/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageCountry: UIImageView!
    @IBOutlet weak var nameCountry: UILabel!
    @IBOutlet weak var capitalCountry: UILabel!
    @IBOutlet weak var areCountry: UILabel!
    @IBOutlet weak var population: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
