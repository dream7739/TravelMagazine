//
//  TravelMagazineTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/28/24.
//

import UIKit

class TravelMagazineTableViewCell: UITableViewCell {
        
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout(){
        titleLabel.font = .primary
        
        subtitleLabel.font = .tertiary
        subtitleLabel.textColor = .lightGray
        subtitleLabel.numberOfLines = 0
        
        dateLabel.font = .quanternary
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right

    }
    
    func configureCell(data: Magazine){
        
        if let url = URL(string: data.photo_image) {
            travelImageView.setImageFromURL(url)
        }else{
            travelImageView.image = UIImage.rupy
        }
        
        titleLabel.text = data.title
        
        subtitleLabel.text = data.subtitle
        
        dateLabel.text = data.date.convertDateFormat()
        
    }
    
    override func layoutSubviews() {
        travelImageView.layer.cornerRadius = 10
    }
}

