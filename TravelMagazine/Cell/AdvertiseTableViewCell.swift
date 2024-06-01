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
    @IBOutlet var addIconLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureData(data: Travel){
        adBackgroundView.backgroundColor = data.randomColor
        titleLabel.text = data.title
    }
    
    func configureLayout(){
        titleLabel.font = .teritary_heavy
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        adBackgroundView.layer.cornerRadius = 12
        
        addIconLabel.font = .quanternary
        addIconLabel.backgroundColor = .white
        addIconLabel.layer.cornerRadius = 5
        addIconLabel.layer.masksToBounds = true
        addIconLabel.textAlignment = .center
    }
}
