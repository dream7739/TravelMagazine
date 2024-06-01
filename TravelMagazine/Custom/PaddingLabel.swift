//
//  PaddingLabel.swift
//  TravelMagazine
//
//  Created by 홍정민 on 6/1/24.
//

import UIKit

class PaddingLabel: UILabel {
    
    var topInset: CGFloat = 8.0
    var bottomInset: CGFloat = 8.0
    var leftInset: CGFloat = 8.0
    var rightInset: CGFloat = 8.0
    
    // UILabel 배경이 그려지고, 텍스트가 그려질 때 패딩을 적용해서 텍스트를 그리기
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    // UILabel은 intrinsicContentSize를 사용해서 텍스트의 높이와 길이에 따라 가로 너비 결정
    // 패딩으로 인해 intrinsicContentSize 변경
    // 패딩 포함해서 반환값 변경해주기 width+좌우여백, height:상하여백
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}
