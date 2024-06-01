//
//  PopularCityViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/27/24.
//

import UIKit

class PopularCityViewController: UIViewController {
    
    @IBOutlet var cityTableView: UITableView!
    
    private let cityList = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView("도시정보")
        configureTableView()
    }
    
}

extension PopularCityViewController {
    func configureTableView(){
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        let cityNib = UINib(nibName: CityTableViewCell.reuseIdentifier, bundle: nil)
        cityTableView.register(cityNib, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        
        let advertiseNib = UINib(nibName: AdvertiseTableViewCell.reuseIdentifier, bundle: nil)
        cityTableView.register(advertiseNib, forCellReuseIdentifier: AdvertiseTableViewCell.reuseIdentifier)
        
        cityTableView.showsVerticalScrollIndicator = false
        
        cityTableView.rowHeight = UITableView.automaticDimension
    }
}

extension PopularCityViewController : UITableViewDelegate, UITableViewDataSource{
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = cityList[indexPath.row]
        
        if data.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdvertiseTableViewCell.reuseIdentifier, for: indexPath) as! AdvertiseTableViewCell
            cell.configureData(data: data)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as! CityTableViewCell
            cell.configureData(data: data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = cityList[indexPath.row]
        
        if data.ad {
            let vc = storyboard?.instantiateViewController(withIdentifier: AdvertiseViewController.reuseIdentifier) as! AdvertiseViewController
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .crossDissolve
            vc.data = data
            present(nav, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: AdvertiseViewController.reuseIdentifier) as! DetailCityViewController
            vc.data = data
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
