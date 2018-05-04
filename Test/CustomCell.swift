//
//  CustomCell.swift
//  Test
//
//  Created by Admin on 4/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SVGKit
import Kingfisher


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
            
            // load imageCountry
            let url = URL(string: unwrappedCounty.flag!)
            let processor = WebpProcessor()
             self.imageCountry.kf.setImage(with: url, options: [.processor(processor)])
            }
    }
    
    struct WebpProcessor: ImageProcessor {
        // `identifier` should be the same for processors with same properties/functionality
        // It will be used when storing and retrieving the image to/from cache.
        let identifier = "com.yourdomain.webpprocessor"
        
        // Convert input data/image to target image and return it.
        func process(item: ImageProcessItem, options: KingfisherOptionsInfo) -> Image? {
            switch item {
            case .image(let image):
                print("already an image")
                return image
            case .data(let data):
                let imageSVG : SVGKImage = SVGKImage(data: data)
                return imageSVG.uiImage
            }
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
