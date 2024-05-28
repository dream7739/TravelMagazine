//
//  TravelMagazineTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/28/24.
//

import UIKit

class TravelMagazineTableViewCell: UITableViewCell {
    
    static let identifier = "TravelMagazineTableViewCell"
    
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout(){
        titleLabel.font = .boldSystemFont(ofSize: 22)
        
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        subtitleLabel.textColor = .lightGray
        subtitleLabel.numberOfLines = 0
        
        dateLabel.font = .systemFont(ofSize: 13, weight: .medium)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right

    }
    
    func configureCell(data: Magazine){
        travelImageView.setImageFromURL(imageStr: data.photo_image)
        
        titleLabel.text = data.title
        
        subtitleLabel.text = data.subtitle
        
        dateLabel.text = data.date.convertDateFormat()
        
    }
    
    override func layoutSubviews() {
        travelImageView.layer.cornerRadius = 10
    }
}
