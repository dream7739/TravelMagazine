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
        travelImageView.layer.cornerRadius = 10
    }
    
}
