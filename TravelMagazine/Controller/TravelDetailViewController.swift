//
//  TravelDetailViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/29/24.
//

import UIKit

class TravelDetailViewController: UIViewController {

    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
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

extension TravelDetailViewController {
    func configureData(data: Travel?){
        guard let data else { return }
        
        if let image = data.travel_image, let url = URL(string: image) {
            travelImageView.setImageFromURL(url)
        }else{
            travelImageView.image = UIImage.rupy
        }
        
        nameLabel.text = data.title
        descriptionLabel.text = data.description
        gradeLabel.text = data.rateDescription
        saveLabel.text = data.saveDescription
    }
    
    func configureLayout(){
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 10
        
        nameLabel.font = .primary
        
        descriptionLabel.font = .tertiary
        descriptionLabel.numberOfLines = 0
        
        gradeLabel.font = .tertiary
        gradeLabel.textColor = .lightGray
        
        saveLabel.font = .tertiary
        saveLabel.textColor = .lightGray
    }
}
