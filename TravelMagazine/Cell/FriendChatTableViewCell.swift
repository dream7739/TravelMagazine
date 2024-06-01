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
    
    @IBOutlet var contentLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    
    func configureData(_ data: Chat){
        profileImageView.image = UIImage(named: data.user.profileImage)
        
        nameLabel.text = data.user.rawValue
        
        contentLabel.text = data.message
        
        dateLabel.text = data.convertedDate(format: "aa hh:mm")
    }
    
    func configureLayout(){
        self.selectionStyle = .none

        profileImageView.layer.cornerRadius = 20
        profileImageView.contentMode = .scaleAspectFill
        
        
        contentLabel.numberOfLines = 0
        contentLabel.layer.borderWidth = 1.0
        contentLabel.layer.cornerRadius = 8
        contentLabel.layer.borderColor = UIColor.lightGray.cgColor
        contentLabel.clipsToBounds = true
        contentLabel.font = .tertiary
        
        dateLabel.font = .quanternary
        dateLabel.textColor = .lightGray
        
        
    }
}
