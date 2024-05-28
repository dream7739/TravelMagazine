//
//  RestaurantTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/28/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    static let identifier = "RestaurantTableViewCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout(){
        nameLabel.font = .boldSystemFont(ofSize: 21)
        
        addressLabel.font = .systemFont(ofSize: 17, weight: .medium)
        addressLabel.textColor = .gray
        
        phoneNumberLabel.font = .systemFont(ofSize: 15, weight: .medium)
        phoneNumberLabel.textColor = .gray
    }
    
    func configureCell(data: Restaurant){
        nameLabel.text = data.name
        addressLabel.text = data.address
        phoneNumberLabel.text = data.phoneNumber
        
        likeButton.setImage(data.likeImage, for: .normal)
    }
    
}
