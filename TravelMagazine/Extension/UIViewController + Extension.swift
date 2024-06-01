//
//  UIViewController + Extension.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/28/24.
//

import UIKit

enum CustomTransitionStyle{
    case pop
    case dismiss
    
    var itemImage : UIImage {
        switch self {
        case .pop:
            return UIImage(systemName: "chevron.backward")!
        case .dismiss:
            return UIImage(systemName: "xmark")!
        }
    }
}

extension UIViewController {
    func configureView(_ title: String){
        navigationItem.title = title
    }
    
    func configureNavItem(style: CustomTransitionStyle){
        let action: Selector
        switch style{
        case .pop:
            action = #selector(popButtonClicked)
        case .dismiss:
            action = #selector(dismissButtonClicked)
        }
        
        let item = UIBarButtonItem(image: style.itemImage, style: .plain, target: self, action: action)
        navigationItem.leftBarButtonItem = item
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func popButtonClicked(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissButtonClicked(){
        dismiss(animated: true)
    }
}
