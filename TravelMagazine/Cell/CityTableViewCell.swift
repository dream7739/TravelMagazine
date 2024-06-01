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
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
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
        
        cityImageView.kf.setImage(with: data.convertedImageURL, placeholder: UIImage(named: "placeholder_rupy"))
        
        likeButton.setImage(data.likeImage, for: .normal)
        
    }
    
    func configureLayout(){
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.cornerRadius = 10
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .medium)
        descriptionLabel.textColor = .darkGray
        
        gradeLabel.font = .systemFont(ofSize: 12)
        gradeLabel.textColor = .darkGray
        
        saveLabel.font = .systemFont(ofSize: 12)
        saveLabel.textColor = .darkGray
        
        likeButton.tintColor = .white
    }
    
}
