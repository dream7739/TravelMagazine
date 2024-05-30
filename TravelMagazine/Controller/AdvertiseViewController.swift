//
//  AdvertiseViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/29/24.
//

import UIKit

class AdvertiseViewController: UIViewController {

    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("광고 화면")
        configureNavItem("xmark", style: .dismiss)
        configureData(data: data)
    }
    
    func configureData(data: Travel?){
        guard let data else { return }
        
        titleImageView.image = UIImage(named: "placeholder_rupy")
        titleImageView.contentMode = .scaleAspectFill
        titleImageView.layer.cornerRadius = 10
        titleImageView.layer.borderWidth = 3
        
        titleLabel.text = data.title
        titleLabel.numberOfLines = 0
        
    
        
    }
  

}
