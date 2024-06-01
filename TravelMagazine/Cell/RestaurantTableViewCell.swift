//
//  RestaurantTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/28/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
        
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout(){
        nameLabel.font = .primary
        
        addressLabel.font = .secondary
        addressLabel.textColor = .gray
        
        phoneNumberLabel.font = .tertiary
        phoneNumberLabel.textColor = .gray
    }
    
    func configureCell(data: Restaurant){
        nameLabel.text = data.name
        addressLabel.text = data.address
        phoneNumberLabel.text = data.phoneNumber
        
        likeButton.setImage(data.likeImage, for: .normal)
    }
    
}


