//
//  AdvertiseTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/27/24.
//

import UIKit

class AdvertiseTableViewCell: UITableViewCell {

    @IBOutlet var adBackgroundView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureData(data: Travel){
        titleLabel.text = data.title
    }
}
