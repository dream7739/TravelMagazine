//
//  UIFont + Extension.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/31/24.
//

import UIKit

extension UIFont {
    //primary . secondary . tertiary. quanternary
    
    static var primary : UIFont {
        return boldSystemFont(ofSize: 21)
    }
    
    static var primary_heavy : UIFont {
        return systemFont(ofSize: 19, weight: .heavy)
    }
    
    static var secondary : UIFont {
        return systemFont(ofSize: 17, weight: .medium)
    }
    
    static var secondary_bold : UIFont {
        return boldSystemFont(ofSize: 17)
    }
    
    static var tertiary : UIFont {
        return systemFont(ofSize: 15, weight: .medium)
    }
    
    static var teritary_heavy: UIFont {
        return systemFont(ofSize: 15, weight: .heavy)
    }
    
    static var quanternary: UIFont {
        return systemFont(ofSize: 13, weight: .medium)
    }
}
