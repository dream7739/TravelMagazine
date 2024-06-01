//
//  UIImageView + Extension.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    //placeholder : 로딩중일때 혹은 이미지 가져오지 못할때
    //fade: 0.1초 서서히 뜨게 함. 로딩시간이 더 빠르면 작동안함
    //indicator : 로딩중임을 알림
    func setImageFromURL(_ url: URL){
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage.rupy,
            options: [
                .transition(.fade(0.1))
            ]){ result in
                switch result{
                case .success(let value): 
                    break
                case .failure(let error):
                    print("error: \(error.errorCode)")
                }
        }
    }
    
    func cancelDownLoadImage(){
        self.kf.cancelDownloadTask()
    }
    
}
