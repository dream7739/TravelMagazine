//
//  MapViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/30/24.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

class MapViewController: UIViewController {
    
    private let mapView =  MKMapView()
    private let currentButton = UIButton()
    
    private let locationManager = CLLocationManager()
    private let defaultLocation = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
    private var status: CLAuthorizationStatus?
    
    private let list = RestaurantList.restaurantArray
    private var restaurantAnnotations: [MKAnnotation] = []
    private var filteredAnnotations: [MKAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView("맛집 지도")
        configureNav()
        
        configureHierarchy()
        configureLayout()
        configureUI()

        locationManager.delegate = self
        mapView.delegate = self
        
        currentButton.addTarget(self, action: #selector(currentButtonClicked), for: .touchUpInside)
    }
 
    private func configureHierarchy(){
        view.addSubview(mapView)
        view.addSubview(currentButton)
    }
    
    private func configureLayout(){
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        currentButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.bottom.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func configureUI(){
        view.backgroundColor = .white
        
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
        
        currentButton.setImage(UIImage(systemName: "location.north.circle"), for: .normal)
        currentButton.tintColor = .systemIndigo
        currentButton.backgroundColor = .white
    }
    
    
    @objc func currentButtonClicked(){
        checkDeviceLocationAuthorization()
        
        if status == .denied  {
            getDeviceLocatitonAuthorizaion()
        }
    }
    

}

extension MapViewController {
    private func configureNav(){
        let filter = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let total = UIBarButtonItem(title: "전체", style: .plain, target: self, action: #selector(totalButtonClicked))
        
        navigationController?.navigationBar.tintColor = .systemIndigo
        navigationItem.rightBarButtonItems = [filter, total]
    }
    
    private func mapViewConfigure(center: CLLocationCoordinate2D){
        //값이 낮을수록 화면을 확대/높으면 축소
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        
        mapView.region = MKCoordinateRegion(center: center, span: span)
        
        mapView.showsUserLocation = true
        
        //어노테이션을 생성
        createAnnotation()
        
        //어노테이션을 적용
        mapView.addAnnotations(restaurantAnnotations)
    }
    
    private func moveToDefaultLocation(){
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        self.mapView.region = MKCoordinateRegion(center: defaultLocation, span: span)
    }
    
    private func createAnnotation(){
        for listItem in list {
            let location = CLLocationCoordinate2D(latitude: listItem.latitude, longitude: listItem.longitude)
            let pin = CustomAnnotation(title: listItem.name, category: listItem.category, coordinate: location)
            restaurantAnnotations.append(pin)
        }
    }
    
    private func getFilteredRestaurant(_ category: Category){
        switch category {
        case .korean, .chinese, .western:
            filteredAnnotations = restaurantAnnotations.filter{ item in
                let convertItem = item as! CustomAnnotation
                guard let convertCategory = convertItem.category else { return false }
                
                if convertCategory == category.title {
                    return true
                }else{
                    return false
                    
                }
            }
        case .etc:
            filteredAnnotations = restaurantAnnotations.filter{ item in
                let convertItem = item as! CustomAnnotation
                guard let convertCategory = convertItem.category else { return false }
                
                let categoryList = [Category.korean.title, Category.chinese.title, Category.western.title]
                
                if !categoryList.contains(convertCategory) {
                    return true
                }else{
                    return false
                }
                
            }
            
        }

    }
    
    @objc func filterButtonClicked(){
        let categorySheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for category in Category.allCases {
            let action = UIAlertAction(title: category.title, style: .default){ _ in
                self.moveToDefaultLocation()
                self.getFilteredRestaurant(category)
                self.mapView.removeAnnotations(self.restaurantAnnotations)
                self.mapView.addAnnotations(self.filteredAnnotations)
            }
            
            categorySheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        categorySheet.addAction(cancelAction)
        
        present(categorySheet, animated: true)
    }
    
    @objc func totalButtonClicked(){
        moveToDefaultLocation()
        mapView.removeAnnotations(restaurantAnnotations)
        mapView.addAnnotations(restaurantAnnotations)
    }
    
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier) as? CustomAnnotationView
        
        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
        }else{
            if annotation.category == Category.korean.title {
                let image = UIImage(systemName: "heart.fill")
                annotationView!.mainImageView.image = image
            }else{
                annotationView!.mainImageView.image = UIImage(named: "placeholder_rupy")
            }
            
            annotationView!.descriptionLabel.text = annotation.title
            
        }
        
        return annotationView
    }
    
}

extension MapViewController {
    // 기기 자체의 위치서비스 권한 확인
    // 가능하면 유저가 선택한 위치서비스 권한 확인
    // 가능하지 않다면 설정화면으로 유도
    private func checkDeviceLocationAuthorization(){
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization()
        }else{
            getDeviceLocatitonAuthorizaion()
        }
        
    }
    
    //유저의 위치서비스 권한 확인
    private func checkCurrentLocationAuthorization(){
        if #available(iOS 14, *){
            status = locationManager.authorizationStatus
        }else{
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            mapViewConfigure(center: defaultLocation)
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print(status)
        }
        
    }
    
    private func getDeviceLocatitonAuthorizaion(){
        let alert = UIAlertController(
            title: "위치서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요(필수권한)",
            message: nil,
            preferredStyle: .alert
        )
        
        let setting = UIAlertAction(title: "설정으로 이동", style: .default){ _ in
            if let setting = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(setting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(setting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    
    //사용자 권한상태 변경, 인스턴스 생성 시 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
    //권한이 있으면 위치를 받아올 수 있고, 그러면 해당 함수가 실행
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        if let coordinate = locations.last?.coordinate {
            mapViewConfigure(center: coordinate)
        }
        
        manager.stopUpdatingLocation()
    }
}



