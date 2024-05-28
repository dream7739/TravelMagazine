//
//  RestaurantViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import UIKit


class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var koreanButton: UIButton!
    @IBOutlet var chineseButton: UIButton!
    @IBOutlet var westernButton: UIButton!
    @IBOutlet var etcButton: UIButton!
    @IBOutlet var tagButtonCollection : [UIButton]!
    
    @IBOutlet var restaurantTableView: UITableView!
    
    private let restaurantList = RestaurantList.restaurantArray
    private var filteredList:[Restaurant] = []
    private let categoryTitleList = ["한식", "중식", "양식", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        searchTextField.clearButtonMode = .whileEditing
        
        for (idx, button) in tagButtonCollection.enumerated(){
            designButton(button, idx)
        }
        
        filteredList = restaurantList
    }
    
    
    @IBAction func searchTextChanged(_ sender: UITextField) {
        //앞 뒤 공백을 제외한 단어를 검색어로 지정
        let searchText = sender.text!.trimmingCharacters(in: .whitespaces)
        
        //1. 검색어가 ""가 아니면 검색어를 찾는다
        //2. 검색어가 ""면 restaurantList를 보여준다.
        //3. 중복으로 restaurantList값을 보여주지 않기위해서 count 체크를 해서 전체배열과 같으면 갱신하지 않는다.
        
        if !searchText.isEmpty {
            filterRestaurant(searchText)
        }else if filteredList.count != restaurantList.count{
            filteredList = restaurantList
            restaurantTableView.reloadData()
        }
    }
    
    @IBAction func categoryButtonClicked(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        searchTextField.text = title

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
        
        let nib = UINib(nibName: RestaurantTableViewCell.identifier, bundle: nil)
        restaurantTableView.register(nib, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        
        restaurantTableView.rowHeight = UITableView.automaticDimension
        restaurantTableView.keyboardDismissMode = .onDrag
    }

    private func designButton(_ sender: UIButton, _ idx: Int){
        sender.layer.cornerRadius = 15
        sender.layer.borderWidth = 1.5
        sender.layer.borderColor = UIColor.systemIndigo.cgColor
        sender.tintColor = .systemIndigo
        
        let buttonTitle = "# \(categoryTitleList[idx])"
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
                !categoryTitleList.contains($0.category)
            }
        }else{
            filteredList = restaurantList.filter{
                $0.category == category
            }
        }
        
        restaurantTableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.configureCell(data: filteredList[indexPath.row])
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        
        return cell
    }
    
}
