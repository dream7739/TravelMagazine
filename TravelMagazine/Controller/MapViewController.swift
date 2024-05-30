//
//  MapViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/30/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    private let list = RestaurantList.restaurantArray
    private let categoryList = RestaurantList.categoryArray
    private var foodAnnotations: [MKAnnotation] = []
    private var filteredAnnotations: [MKAnnotation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView("맛집 지도")
        configureNav()
        mapViewConfigure()
        
    }
    
    private func configureNav(){
        let item = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.rightBarButtonItem = item
    }
    
    private func mapViewConfigure(){
        mapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
        
        //값이 낮을수록 화면을 확대/높으면 축소
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        
        mapView.region = MKCoordinateRegion(center: center, span: span)
        
        //커스텀 뷰를 등록한다. 테이블 뷰 처럼 재사용 하는것 같다
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
        
        //어노테이션을 생성
        createAnnotation()
        
        //어노테이션을 적용
        mapView.addAnnotations(foodAnnotations)
    }
    
    private func createAnnotation(){
        for listItem in list {
            let location = CLLocationCoordinate2D(latitude: listItem.latitude, longitude: listItem.longitude)
            let pin = CustomAnnotation(title: listItem.name, category: listItem.category, coordinate: location)
            foodAnnotations.append(pin)
        }
    }
    
    @objc func filterButtonClicked(){
        let foodActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for category in categoryList {
            let action = UIAlertAction(title: category, style: .default,
                                       handler: { _ in self.filterCategoryFood(category) }
            )
            
            foodActionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        foodActionSheet.addAction(cancelAction)
        
        present(foodActionSheet, animated: true)
    }
    
    func filterCategoryFood(_ category: String){
        if category == "기타" {
            filteredAnnotations = foodAnnotations.filter{ item in
                let convertItem = item as! CustomAnnotation
                guard let convertCategory = convertItem.category else { return false }
                
                if !categoryList.contains(convertCategory) {
                    return true
                }
                
                return false
            }
        }else if category == "전체"{
            filteredAnnotations = foodAnnotations
        }else {
            filteredAnnotations = foodAnnotations.filter{ item in
                let convertItem = item as! CustomAnnotation
                guard let convertCategory = convertItem.category else { return false }
                
                if convertCategory == category{
                    return true
                }
                
                return false
            }
        }
        
        mapView.removeAnnotations(foodAnnotations)
        mapView.addAnnotations(filteredAnnotations)
        
    }
    
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
        }else{
            if annotation.category == "한식" {
                annotationView?.image = UIImage(systemName: "heart.fill")
            }else{
                annotationView?.image = UIImage(named: "placeholder_rupy")
            }
            
            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
        
        return annotationView
    }
    
}
