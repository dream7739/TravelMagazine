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
    
    func koreanLangCheck() -> Bool {
        let pattern = "^[가-힣a-zA-Z\\s]*$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive){
            let range = NSRange(location: 0, length: self.utf16.count)
            if regex.firstMatch(in: self, options: [], range: range) != nil {
                return true
            }
        }
        return false
    }
    
}
