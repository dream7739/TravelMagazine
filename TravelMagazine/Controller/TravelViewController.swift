//
//  TravelViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import UIKit

class TravelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var travelTableView: UITableView!
    
    private let travelMegazine = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("SeSAC Travel")
        configureTableView()
    }
    
    func configureTableView(){
        travelTableView.delegate = self
        travelTableView.dataSource = self
        
        let nib = UINib(nibName: TravelMagazineTableViewCell.identifier, bundle: nil)
        travelTableView.register(nib, forCellReuseIdentifier: TravelMagazineTableViewCell.identifier)
        
        travelTableView.rowHeight = UITableView.automaticDimension
        travelTableView.separatorStyle = .none
    }
    
    //스크롤으로 인해서 셀이 화면에서 보이지 않게 되면 호출
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelMagazineTableViewCell.identifier, for: indexPath) as! TravelMagazineTableViewCell
        
        cell.travelImageView.cancelDownLoadImage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelMegazine.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelMagazineTableViewCell.identifier, for: indexPath) as! TravelMagazineTableViewCell
        
        cell.configureCell(data: travelMegazine[indexPath.row])
    
        cell.selectionStyle = .none
        
        return cell
    }
    
}
