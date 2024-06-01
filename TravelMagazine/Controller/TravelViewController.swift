//
//  TravelViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/27/24.
//

import UIKit

class TravelViewController: UIViewController {
    
    @IBOutlet var travelTableView: UITableView!
    
    private let travelList = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView("도시정보")
        configureTableView()
    }
    
}

extension TravelViewController {
    func configureTableView(){
        travelTableView.delegate = self
        travelTableView.dataSource = self
        
        let cityNib = UINib(nibName: TravelTableViewCell.reuseIdentifier, bundle: nil)
        travelTableView.register(cityNib, forCellReuseIdentifier: TravelTableViewCell.reuseIdentifier)
        
        let advertiseNib = UINib(nibName: AdvertiseTableViewCell.reuseIdentifier, bundle: nil)
        travelTableView.register(advertiseNib, forCellReuseIdentifier: AdvertiseTableViewCell.reuseIdentifier)
        
        travelTableView.showsVerticalScrollIndicator = false
        
        travelTableView.rowHeight = UITableView.automaticDimension
    }
}

extension TravelViewController : UITableViewDelegate, UITableViewDataSource{
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
        return travelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = travelList[indexPath.row]
        
        if data.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdvertiseTableViewCell.reuseIdentifier, for: indexPath) as! AdvertiseTableViewCell
            cell.configureData(data: data)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.reuseIdentifier, for: indexPath) as! TravelTableViewCell
            cell.configureData(data: data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = travelList[indexPath.row]
        
        if data.ad {
            let vc = storyboard?.instantiateViewController(withIdentifier: AdvertiseViewController.reuseIdentifier) as! AdvertiseViewController
            vc.data = data
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .crossDissolve
            
            present(nav, animated: true)
            
        }else{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: TravelDetailViewController.reuseIdentifier) as! TravelDetailViewController
            
            vc.data = data
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
