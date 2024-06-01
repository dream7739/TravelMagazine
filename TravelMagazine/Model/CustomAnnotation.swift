//
//  CustomAnnotation.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/30/24.
//

import MapKit

class CustomAnnotation : NSObject, MKAnnotation {
    var title: String?
    var category: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, category: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.category = category
        self.coordinate = coordinate
    }
}

class CustomAnnotationView : MKAnnotationView {
    static let identifier = "CustomAnnotationView"
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemIndigo
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    
    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.backgroundColor = .white
        self.addSubview(mainImageView)
        self.addSubview(descriptionLabel)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 1).isActive = true
        mainImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 2).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        canShowCallout = true
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemIndigo
        rightCalloutAccessoryView = button
        
    }
    
}
