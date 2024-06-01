//
//  ReusableViewProtocol.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/31/24.
//

import UIKit

protocol ReusdentifierProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController : ReusdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell : ReusdentifierProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
