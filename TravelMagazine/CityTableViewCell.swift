//
//  CityTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/27/24.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(data: Travel){
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        let rating = data.grade ?? 0
        ratingLabel.text = String(format: "%.2f", rating)
        
        let saveCount = data.save ?? 0
        saveLabel.text = "저장" + saveCount.formatted()
        
        if let imageURL =  data.travel_image {
            let url = URL(string: imageURL)
            cityImageView.kf.setImage(with: url)
        }
    }
    
}
