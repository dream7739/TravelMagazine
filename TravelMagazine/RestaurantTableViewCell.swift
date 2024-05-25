//
//  RestaurantTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
