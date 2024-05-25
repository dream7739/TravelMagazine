//
//  RestaurantTableViewController.swift
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantTableView.rowHeight = 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        let data = restaurantList[indexPath.row]
        
        cell.nameLabel.text = data.name
        cell.addressLabel.text = data.address
        cell.phoneNumberLabel.text = data.phoneNumber
        
        return cell
    }

}
