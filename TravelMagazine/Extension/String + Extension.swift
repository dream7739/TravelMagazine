//
//  String + Extension.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import Foundation

extension String {
    func convertDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        guard let date = dateFormatter.date(from: self) else { return "" }
        
        let dateStrFormatter = DateFormatter()
        dateStrFormatter.dateFormat = "yy년 MM월 dd일"
        let travelDateStr = dateStrFormatter.string(from: date)
        return travelDateStr
    }
}
