//
//  TravelTableViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import UIKit

class TravelTableViewController: UITableViewController {

    private let travelMegazine = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 450
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelMegazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell", for: indexPath) as! TravelTableViewCell
        
        let data = travelMegazine[indexPath.row]
        
        cell.travelImageView.setImageFromURL(imageStr: data.photo_image)
        cell.travelImageView.layer.cornerRadius = 10
        
        cell.titleLabel.text = data.title
        
        cell.subtitleLabel.text = data.subtitle
        
        cell.dateLabel.text = data.date.convertDateFormat()
        
        return cell
    }
    
}
