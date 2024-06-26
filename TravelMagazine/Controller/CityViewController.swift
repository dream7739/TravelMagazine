//
//  CityViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/29/24.
//

import UIKit

class CityViewController: UIViewController {
    @IBOutlet var citySearchBar: UISearchBar!
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var cityTableView: UITableView!
    
    private let list = CityInfo.city
    private var filteredList: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("인기 도시")
        configureTableView()
        configureSegment()
        configureSearchBar()
    }
}

extension CityViewController {
    private func configureTableView(){
        
        filteredList = list
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.rowHeight = 150
        cityTableView.separatorStyle = .none
        cityTableView.keyboardDismissMode = .onDrag
        
        let nib = UINib(nibName: CityTableViewCell.reuseIdentifier, bundle: nil)
        cityTableView.register(nib, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
    }
    
    private func configureSegment(){
        citySegment.addTarget(self, action: #selector(segmentClicked), for: .valueChanged)
        let segmentCount = citySegment.numberOfSegments
    
        for i in 0..<segmentCount {
            citySegment.setTitle(CityType(rawValue: i)?.typeName, forSegmentAt: i)
        }
    }
    
    private func configureSearchBar(){
        citySearchBar.delegate = self
        citySearchBar.searchTextField.tintColor = .black
        citySearchBar.searchTextField.placeholder = "도시를 입력해주세요"
    }
    
    @objc func segmentClicked(sender: UISegmentedControl){
        filterCityList(sender.selectedSegmentIndex)
        cityTableView.reloadData()
        cityTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    private func filterCityList(_ idx: Int){
        filteredList = CityType(rawValue: idx)!.cityList
    }
    
}

extension CityViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as! CityTableViewCell
        cell.configureData(data: filteredList[indexPath.row])
        return cell
    }
}

extension CityViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let input = searchBar.text!
        
        if !examineEmptyText(input) && input.koreanLangCheck() {
            getFilteredCityList(input)
        }else if examineEmptyText(input) && filteredList.count != list.count {
            filteredList = list
        }
                
        cityTableView.reloadData()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let input = searchBar.text!
        
        if !examineEmptyText(input) && input.koreanLangCheck(){
            getFilteredCityList(input)
        }else if examineEmptyText(input) && filteredList.count != list.count {
            filteredList = list
        }
        
        cityTableView.reloadData()
    }
    
    func examineEmptyText(_ input: String) -> Bool {
        return input.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func getFilteredCityList(_ input: String){
        filteredList = list.filter{ 
            $0.city_name.localizedCaseInsensitiveContains(input) ||
            $0.city_english_name.localizedCaseInsensitiveContains(input) ||
            $0.city_explain.localizedCaseInsensitiveContains(input)
        }
    }
}
