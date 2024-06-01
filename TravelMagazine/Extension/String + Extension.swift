//
//  String + Extension.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import Foundation

extension String {
    func convertDateFormat() -> String {
        let dateToStrFormatter = DateFormatter()
        dateToStrFormatter.dateFormat = "yyMMdd"
        guard let date = dateToStrFormatter.date(from: self) else { return "" }
        
        let strToDateFormatter = DateFormatter()
        strToDateFormatter.dateFormat = "yy년 MM월 dd일"
        let convertedDate = strToDateFormatter.string(from: date)
        return convertedDate
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
