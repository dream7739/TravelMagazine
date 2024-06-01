//
//  CityTableViewCell.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/29/24.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet var cityBackgroundView: UIView!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    // clipsToBounds, maskToBounds
    
    // 그림자 : 그림자view > 배경 view > imageView
    // shadowRadius : 그림자의 블러 정도 지정 (0일때 선같이 진한 그림자 높을 수록 퍼지는 효과)
    // shadowOffset: 그림자의 위치가 기존 레이어보다 얼마만큼 떨어진 지점에 위치하는지
    // CGSize(width: 50, height: 50)을 할당하면 기존 레이어의 위치에서 가로로 50, 세로로 50 만큼 떨어진 지점에 레이어와 똑같은 크기의 그림자
    func configureLayout(){
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 3, height: 5)
        
        
        cityBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        cityBackgroundView.layer.cornerRadius = 30
        cityBackgroundView.clipsToBounds = true
        
        cityImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .primary_heavy
        nameLabel.textAlignment = .right
        nameLabel.textColor = .white
        
        detailNameLabel.font = .quanternary
        detailNameLabel.textAlignment = .left
        detailNameLabel.textColor = .white
        detailNameLabel.backgroundColor = .black
        detailNameLabel.layer.opacity = 0.8
    }
    
    func configureData(data: City){
 
        nameLabel.text = data.nameDescription
        detailNameLabel.text = data.detailDesciption
  
        if let url = URL(string: data.city_image) {
            cityImageView.setImageFromURL(url)
        }else{
            cityImageView.image = UIImage.rupy
        }
        
    }
}
