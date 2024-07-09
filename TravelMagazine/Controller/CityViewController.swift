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
    
    let viewModel = CityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("인기 도시")
        configureTableView()
        configureSegment()
        configureSearchBar()
        bindData()
    }
    
    func bindData(){
        viewModel.outputList.bind { value in
            self.cityTableView.reloadData()
            if !value.isEmpty{
                self.cityTableView.scrollToRow(
                    at: IndexPath(row: 0, section: 0),
                    at: .top,
                    animated: false
                )
            }
        }
        
    }
}

extension CityViewController {
    private func configureTableView(){
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
        
        for idx in 0..<citySegment.numberOfSegments {
            citySegment.setTitle(CityType.allCases[idx].typeName, forSegmentAt: idx)
        }
    }
    
    private func configureSearchBar(){
        citySearchBar.delegate = self
        citySearchBar.searchTextField.tintColor = .black
        citySearchBar.searchTextField.placeholder = "도시를 입력해주세요"
    }
    
    @objc func segmentClicked(sender: UISegmentedControl){
        viewModel.segmentInput.value = sender.selectedSegmentIndex
    }
    
    
}

extension CityViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as! CityTableViewCell
        cell.configureData(data: viewModel.outputList.value[indexPath.row])
        return cell
    }
}

extension CityViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let input = searchBar.text!
        viewModel.searchInput.value = input
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let input = searchBar.text!
        viewModel.searchInput.value = input
    }
}
