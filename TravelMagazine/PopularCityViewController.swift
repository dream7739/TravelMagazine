//
//  PopularCityViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/27/24.
//

import UIKit

class PopularCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var cityTableView: UITableView!
    
    private let cityList = TravelInfo().travel
    private let cityIdentifier = "CityTableViewCell"
    private let advertiseIdentifier = "AdvertiseTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "도시 상세 정보"
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        let cityNib = UINib(nibName: cityIdentifier, bundle: nil)
        cityTableView.register(cityNib, forCellReuseIdentifier: cityIdentifier)
        
        let advertiseNib = UINib(nibName: advertiseIdentifier, bundle: nil)
        cityTableView.register(advertiseNib, forCellReuseIdentifier: advertiseIdentifier)
        
        cityTableView.showsVerticalScrollIndicator = false
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cityList[indexPath.row].ad ? 70 : 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = cityList[indexPath.row]
        
        if data.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: advertiseIdentifier, for: indexPath) as! AdvertiseTableViewCell
            cell.configureData(data: data)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cityIdentifier, for: indexPath) as! CityTableViewCell
            cell.configureData(data: data)
            return cell
        }
        
    }
    
    
    
}
