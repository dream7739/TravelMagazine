//
//  CityInfoViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/29/24.
//

import UIKit

class CityInfoViewController: UIViewController {
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var cityTableView: UITableView!
    
    private let list = CityInfo.city
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("인기 도시")
        configureTableView()
    }
    
}

extension CityInfoViewController {
    private func configureTableView(){
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.rowHeight = 150
        
        let nib = UINib(nibName: "CityInfoTableViewCell", bundle: nil)
        cityTableView.register(nib, forCellReuseIdentifier: CityInfoTableViewCell.identifier)
    }
}

extension CityInfoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoTableViewCell.identifier, for: indexPath) as! CityInfoTableViewCell
        cell.configureData(data: list[indexPath.row])
        return cell
    }
    
    
}
