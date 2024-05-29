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
    private var filteredList: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("인기 도시")
        configureTableView()
        configureSegment()
    }
}

extension CityInfoViewController {
    private func configureTableView(){
        
        filteredList = list
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.rowHeight = 150
        
        let nib = UINib(nibName: CityInfoTableViewCell.identifier, bundle: nil)
        cityTableView.register(nib, forCellReuseIdentifier: CityInfoTableViewCell.identifier)
    }
    
    private func configureSegment(){
        citySegment.addTarget(self, action: #selector(segmentClicked), for: .valueChanged)
    }
    
    @objc func segmentClicked(sender: UISegmentedControl){
        filterCityList(sender.selectedSegmentIndex)
        cityTableView.reloadData()
    }
    
    private func filterCityList(_ idx: Int){
        switch idx {
        case 0:
            filteredList = list
        case 1:
            filteredList = list.filter{ $0.domestic_travel == true }
        case 2:
            filteredList = list.filter{ $0.domestic_travel == false }
        default:
            return
        }
    }
    
}

extension CityInfoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoTableViewCell.identifier, for: indexPath) as! CityInfoTableViewCell
        cell.configureData(data: filteredList[indexPath.row])
        return cell
    }
    
    
}
