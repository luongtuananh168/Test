//
//  CustomCell.swift
//  Test
//
//  Created by Admin on 4/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SVGKit

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
    
    var country: Country?{
        didSet{
            guard let unwrappedCounty = country else {
                return
            }
            nameCountry.text = unwrappedCounty.name
            capitalCountry.text = unwrappedCounty.capital
            areCountry.text = String(format: "%f", unwrappedCounty.area)
            population.text = String(format: "%f", unwrappedCounty.population)
            
            // get data imageView
            if let urlImageCountry = unwrappedCounty.flag{
                DispatchQueue.global(qos: .userInteractive).async {
                    //share task async
                    do{
                        let url = URL(string: urlImageCountry)
                        let data = try Data(contentsOf: url!)
                        
                        //update UI
                        DispatchQueue.main.async {
                            let imageSVG : SVGKImage = SVGKImage(data: data)
                            self.imageCountry.image = imageSVG.uiImage
                        }
                    }catch{}
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
