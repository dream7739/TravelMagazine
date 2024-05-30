//
//  DetailCityViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/29/24.
//

import UIKit

class DetailCityViewController: UIViewController {

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("관광지 화면")
        configureNavItem("chevron.left", style: .pop)
        configureData(data: data)
        configureLayout()
    }

}

extension DetailCityViewController {
    func configureData(data: Travel?){
        guard let data else { return }
        
        if let image = data.travel_image {
            cityImageView.setImageFromURL(imageStr: image)
        }
        
        nameLabel.text = data.title
        descriptionLabel.text = data.description
        infoLabel.text = data.rateDescription
        saveLabel.text = data.saveDescription
    }
    
    func configureLayout(){
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.cornerRadius = 10
        
        nameLabel.font = .boldSystemFont(ofSize: 18)
        
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.textColor = .lightGray
        
        saveLabel.font = .systemFont(ofSize: 13)
        saveLabel.textColor = .lightGray
    }
}
