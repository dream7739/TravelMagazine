//
//  Observable.swift
//  TravelMagazine
//
//  Created by 홍정민 on 7/9/24.
//

import Foundation

class Observable<T> {
    var closure: ((T) -> Void)?
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T){
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void){
        closure(value)
        self.closure = closure
    }
}
