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
    
    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        canShowCallout = true
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        rightCalloutAccessoryView = button
        frame = CGRect(x: 0, y: 0, width: 30, height: 30)

    }
    
}
