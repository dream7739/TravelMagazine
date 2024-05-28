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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView("도시정보")
        configureTableView()
    }
    
    func configureTableView(){
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        let cityNib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        cityTableView.register(cityNib, forCellReuseIdentifier: CityTableViewCell.identifier)
        
        let advertiseNib = UINib(nibName: AdvertiseTableViewCell.identifier, bundle: nil)
        cityTableView.register(advertiseNib, forCellReuseIdentifier: AdvertiseTableViewCell.identifier)
        
        cityTableView.showsVerticalScrollIndicator = false
    }
    
    //오른쪽에 swipe 액션 생성
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let share = UIContextualAction(style: .normal, title: "share") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("share 클릭")
            success(true)
        }
        
        share.image = UIImage(systemName: "square.and.arrow.up")
        share.backgroundColor = .systemTeal
        
        return UISwipeActionsConfiguration(actions: [share])
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
            let cell = tableView.dequeueReusableCell(withIdentifier: AdvertiseTableViewCell.identifier, for: indexPath) as! AdvertiseTableViewCell
            cell.configureData(data: data)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
            cell.configureData(data: data)
            return cell
        }
        
    }
    
    
    
}
