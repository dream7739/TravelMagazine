//
//  MyChatTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 6/1/24.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    
    func configureData(_ data: Chat){
        
        contentTextView.text = data.message
        
        dateLabel.text = data.convertedDate(format: "aa hh:mm")
    }
    
    func configureLayout(){
        self.selectionStyle = .none
        
        contentTextView.layer.borderWidth = 1.0
        contentTextView.layer.cornerRadius = 8
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.clipsToBounds = true
        contentTextView.font = .tertiary
        contentTextView.isEditable = false
        contentTextView.isScrollEnabled = false
        contentTextView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        dateLabel.font = .quanternary
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
        
    }
}
