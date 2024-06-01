//
//  MagazineViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/25/24.
//

import UIKit

class MagazineViewController: UIViewController  {
    
    @IBOutlet var magazineTableView: UITableView!
    
    private let magazine = MagazineInfo.magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("SeSAC Travel")
        configureTableView()
    }
}

extension MagazineViewController {
    func configureTableView(){
        magazineTableView.delegate = self
        magazineTableView.dataSource = self
        
        let nib = UINib(nibName: TravelMagazineTableViewCell.reuseIdentifier, bundle: nil)
        magazineTableView.register(nib, forCellReuseIdentifier: TravelMagazineTableViewCell.reuseIdentifier)
        
        magazineTableView.rowHeight = UITableView.automaticDimension
        magazineTableView.separatorStyle = .none
    }
}

extension MagazineViewController: UITableViewDelegate, UITableViewDataSource {
    //스크롤으로 인해서 셀이 화면에서 보이지 않게 되면 호출
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelMagazineTableViewCell.reuseIdentifier, for: indexPath) as! TravelMagazineTableViewCell
        
        cell.travelImageView.cancelDownLoadImage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazine.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelMagazineTableViewCell.reuseIdentifier, for: indexPath) as! TravelMagazineTableViewCell
        
        cell.configureCell(data: magazine[indexPath.row])
    
        cell.selectionStyle = .none
        
        return cell
    }
}
