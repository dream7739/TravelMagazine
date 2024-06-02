//
//  FriendChatTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 6/1/24.
//

import UIKit

class FriendChatTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var contentTextView: UITextView!
    
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    
    func configureData(_ data: Chat){
        profileImageView.image = UIImage(named: data.user.profileImage)
        
        nameLabel.text = data.user.rawValue
        
        contentTextView.text = data.message
        
        dateLabel.text = data.convertedDate(format: "aa hh:mm")
    }
    
    func configureLayout(){
        self.selectionStyle = .none

        profileImageView.layer.cornerRadius = 20
        profileImageView.contentMode = .scaleAspectFill
        
        contentTextView.layer.borderWidth = 1.0
        contentTextView.layer.cornerRadius = 8
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.clipsToBounds = true
        contentTextView.font = .tertiary
        contentTextView.isEditable = false
        contentTextView.isScrollEnabled = false

        dateLabel.font = .quanternary
        dateLabel.textColor = .lightGray
        
    }
}

