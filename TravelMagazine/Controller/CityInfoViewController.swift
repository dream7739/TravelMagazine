//
//  CityInfoViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/29/24.
//

import UIKit

class CityInfoViewController: UIViewController {
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

extension CityInfoViewController {
    private func configureTableView(){
        
        filteredList = list
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.rowHeight = 150
        cityTableView.separatorStyle = .none
        cityTableView.keyboardDismissMode = .onDrag
        
        let nib = UINib(nibName: CityInfoTableViewCell.identifier, bundle: nil)
        cityTableView.register(nib, forCellReuseIdentifier: CityInfoTableViewCell.identifier)
    }
    
    private func configureSegment(){
        citySegment.addTarget(self, action: #selector(segmentClicked), for: .valueChanged)
    }
    
    private func configureSearchBar(){
        citySearchBar.delegate = self
        citySearchBar.searchTextField.tintColor = .black
        citySearchBar.searchTextField.placeholder = "도시를 입력해주세요"
    }
    
    @objc func segmentClicked(sender: UISegmentedControl){
        filterDomesticCityList(sender.selectedSegmentIndex)
        cityTableView.reloadData()
        cityTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    private func filterDomesticCityList(_ idx: Int){
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

extension CityInfoViewController : UISearchBarDelegate {
    
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
