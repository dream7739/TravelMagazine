//
//  MyChatTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 6/1/24.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {
    
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    
    func configureData(_ data: Chat){
        
        contentLabel.text = data.message
        
        dateLabel.text = data.convertedDate(format: "aa hh:mm")
    }
    
    func configureLayout(){
        self.selectionStyle = .none
        
        contentLabel.numberOfLines = 0
        contentLabel.layer.borderWidth = 1.0
        contentLabel.layer.cornerRadius = 8
        contentLabel.layer.borderColor = UIColor.lightGray.cgColor
        contentLabel.clipsToBounds = true
        contentLabel.font = .tertiary
        contentLabel.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        dateLabel.font = .quanternary
        dateLabel.textColor = .lightGray
        
    }
}
