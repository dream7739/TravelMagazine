//
//  UIImageView + Extension.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageFromURL(imageStr: String){
        let imageURL = URL(string: imageStr)
        self.kf.setImage(with: imageURL)
   }
}
