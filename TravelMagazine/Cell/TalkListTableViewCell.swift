//
//  TalkListTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 6/1/24.
//

import UIKit

class TalkListTableViewCell: UITableViewCell {

    @IBOutlet var talkImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout(){
        talkImageView.contentMode = .redraw
        talkImageView.layer.cornerRadius = talkImageView.frame.width / 2
        
        nameLabel.font = .secondary_bold
        
        contentLabel.numberOfLines = 0
        contentLabel.font = .tertiary
        contentLabel.textColor = .gray
        
        dateLabel.font = .quanternary
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right

    }

    func configureData(_ data: ChatRoom){
        nameLabel.text = data.chatroomName
        
        if let talkImage = data.chatroomImage.first{
            talkImageView.image = UIImage(named: talkImage)
        }else {
            talkImageView.image = UIImage.rupy
        }
        
        if let latestChat = data.latestChat {
            contentLabel.text = latestChat.message
            dateLabel.text = latestChat.convertedDate
        }
        
    }
  
    
}
