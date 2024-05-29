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
}

extension UIViewController {
    func configureView(_ title: String){
        navigationItem.title = title
    }
    
    func configureNavItem(_ image: String, style: CustomTransitionStyle){
        let action: Selector
        switch style{
        case .pop:
            action = #selector(popButtonClicked)
        case .dismiss:
            action = #selector(dismissButtonClicked)
        }
        
        let item = UIBarButtonItem(image: UIImage(systemName: image), style: .plain, target: self, action: action)
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
