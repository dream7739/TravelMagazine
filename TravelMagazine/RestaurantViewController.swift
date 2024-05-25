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
    @IBOutlet var restaurantTableView: UITableView!
    
    private let restaurantList = RestaurantList().restaurantArray
    private var filteredList:[Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantTableView.rowHeight = 150
        restaurantTableView.keyboardDismissMode = .onDrag
        
        searchTextField.clearButtonMode = .whileEditing
        
        filteredList = restaurantList
    }
    
    func filterRestaurant(_ searchText: String){
        filteredList = restaurantList.filter{
            $0.name.lowercased().contains(searchText)
        }
        
        restaurantTableView.reloadData()
    }
    
    @IBAction func searchTextChanged(_ sender: UITextField) {
        //앞 뒤 공백을 제외한 단어를 검색어로 지정
        let searchText = sender.text!.trimmingCharacters(in: .whitespaces)
        
        //1. 검색어가 ""가 아니면 검색어를 찾는다
        //2. 검색어가 ""면 restaurantList를 보여준다.
        //3. 중복으로 restaurantList값을 보여주지 않기위해서 count 체크를 해서 전체배열과 같으면 갱신하지 않는다.
        
        if !searchText.isEmpty{
            filterRestaurant(searchText)
        }else if filteredList.count != restaurantList.count{
            filteredList = restaurantList
            restaurantTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        let data = filteredList[indexPath.row]
        
        cell.nameLabel.text = data.name
        cell.addressLabel.text = data.address
        cell.phoneNumberLabel.text = data.phoneNumber
        
        return cell
    }
    
}
