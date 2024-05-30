//
//  RestaurantViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import UIKit


class RestaurantViewController: UIViewController{
    
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var koreanButton: UIButton!
    @IBOutlet var chineseButton: UIButton!
    @IBOutlet var westernButton: UIButton!
    @IBOutlet var etcButton: UIButton!
    @IBOutlet var tagButtonCollection : [UIButton]!
    @IBOutlet var restaurantTableView: UITableView!
    
    private let categoryList = RestaurantList.categoryArray
    private let restaurantList = RestaurantList.restaurantArray
    private var filteredList:[Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapButton()
        
        configureTableView()
        
        configureSearchView()
        
        for (idx, button) in tagButtonCollection.enumerated(){
            designButton(button, idx)
        }
        
        filteredList = restaurantList
    }
    
    @IBAction func categoryButtonClicked(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        
        let category = title.replacingOccurrences(of: "#", with: "").trimmingCharacters(in: .whitespaces)
        
        filterCategory(category)
    }
    
    @objc func likeButtonClicked(sender: UIButton){
        filteredList[sender.tag].like.toggle()
        restaurantTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    private func configureTableView(){
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        
        let nib = UINib(nibName: RestaurantTableViewCell.reuseIdentifier, bundle: nil)
        restaurantTableView.register(nib, forCellReuseIdentifier: RestaurantTableViewCell.reuseIdentifier)
        
        restaurantTableView.rowHeight = UITableView.automaticDimension
        restaurantTableView.keyboardDismissMode = .onDrag
    }
    
    private func configureSearchView(){
        //searchResultsController라는 걸 따로 넣어 줄 수 있음. 같은 VC에서 검색결과 -> nil
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "음식점을 검색해주세요"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.searchTextField.tintColor = .systemIndigo
        searchController.searchBar.searchTextField.clearsOnBeginEditing = true
        searchController.searchBar.tintColor = .systemIndigo
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
    }
    
}

extension RestaurantViewController {
    func configureMapButton(){
        mapButton.setImage(UIImage(systemName: "map"), for: .normal)
        mapButton.tintColor = .systemIndigo
        mapButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
    }
    
    @objc func mapButtonClicked(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func designButton(_ sender: UIButton, _ idx: Int){
        sender.layer.cornerRadius = 15
        sender.layer.borderWidth = 1.5
        sender.layer.borderColor = UIColor.systemIndigo.cgColor
        sender.tintColor = .systemIndigo
        
        let buttonTitle = "# \(categoryList[idx])"
        sender.setTitle(buttonTitle, for: .normal)
    }
    
    private func filterRestaurant(_ searchText: String){
        filteredList = restaurantList.filter{
            $0.name.lowercased().contains(searchText)
        }
        
        restaurantTableView.reloadData()
    }
    
    private func filterCategory(_ category: String){
        if category == "기타"{
            filteredList = restaurantList.filter{
                !categoryList.contains($0.category)
            }
        }else{
            filteredList = restaurantList.filter{
                $0.category == category
            }
        }
        
        restaurantTableView.reloadData()
    }
}

extension RestaurantViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.reuseIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.configureCell(data: filteredList[indexPath.row])
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
}

// UISearchResultsUpdating을 준수
// UISearchResultsUpdating의 Delegate가 되도록 설정
// searchController.searchResultsUpdater = self
extension RestaurantViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!.trimmingCharacters(in: .whitespaces).lowercased()
        
        //1. 검색어가 ""가 아니면 검색어를 찾는다
        //2. 검색어가 ""면 restaurantList를 보여준다.
        //3. 중복으로 restaurantList값을 보여주지 않기위해서 count 체크를 해서 전체배열과 같으면 갱신하지 않는다.
        
        if !searchText.isEmpty {
            filteredList = restaurantList.filter{
                $0.name.lowercased().contains(searchText)
            }
        }else if filteredList.count != restaurantList.count{
            filteredList = restaurantList
        }
        
        restaurantTableView.reloadData()
        
    }
    
    
}
