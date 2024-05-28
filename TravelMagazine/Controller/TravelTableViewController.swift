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
        configureView("SeSAC Travel")
        configureTableView()
    }
    
    func configureTableView(){
        tableView.rowHeight = 450
        tableView.separatorStyle = .none
    }
    
    //스크롤으로 인해서 셀이 화면에서 보이지 않게 되면 호출
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! TravelTableViewCell
        cell.travelImageView.cancelDownLoadImage()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelMegazine.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell", for: indexPath) as! TravelTableViewCell
        
        let data = travelMegazine[indexPath.row]
        
        cell.travelImageView.setImageFromURL(imageStr: data.photo_image)
        
        cell.titleLabel.text = data.title
        
        cell.subtitleLabel.text = data.subtitle
        
        cell.dateLabel.text = data.date.convertDateFormat()
        
        cell.selectionStyle = .none
    
        return cell
    }
    
}
