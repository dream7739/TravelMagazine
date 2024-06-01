//
//  CityTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/27/24.
//

import UIKit
import Kingfisher

class TravelTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureData(data: Travel){
        titleLabel.text = data.title
        
        descriptionLabel.text = data.description
        
        gradeLabel.text = data.rateDescription
        
        saveLabel.text = data.saveDescription
        
        if let image = data.travel_image, let url = URL(string: image) {
            travelImageView.setImageFromURL(url)
        }else{
            travelImageView.image = UIImage.rupy
        }
        
        likeButton.setImage(data.likeImage, for: .normal)
        
    }
    
    func configureLayout(){
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 10
        
        titleLabel.font = .secondary_bold
        
        descriptionLabel.font = .quanternary
        descriptionLabel.textColor = .darkGray
        
        gradeLabel.font = .quanternary
        gradeLabel.textColor = .darkGray
        
        saveLabel.font = .quanternary
        saveLabel.textColor = .darkGray
        
        likeButton.tintColor = .white
    }
    
}
