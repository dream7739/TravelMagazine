//
//  CityInfoTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/29/24.
//

import UIKit

class CityInfoTableViewCell: UITableViewCell {

    static let identifier = "CityInfoTableViewCell"
    @IBOutlet var cityBackgroundView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    // clipsToBounds, maskToBounds
    func configureLayout(){
        cityBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        cityBackgroundView.layer.cornerRadius = 30
        cityBackgroundView.layer.masksToBounds = true
        cityBackgroundView.layer.opacity = 0.3
        
        cityImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .systemFont(ofSize: 19, weight: .heavy)
        nameLabel.textAlignment = .right
        nameLabel.textColor = .white
        
        detailNameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        detailNameLabel.textAlignment = .left
        detailNameLabel.textColor = .white
        detailNameLabel.backgroundColor = .black
        detailNameLabel.layer.opacity = 0.8
    }
    
    func configureData(data: City){
 
        nameLabel.text = data.nameDescription
        detailNameLabel.text = data.detailDesciption
  
        cityImageView.setImageFromURL(imageStr: data.city_image)
        
    }
}
