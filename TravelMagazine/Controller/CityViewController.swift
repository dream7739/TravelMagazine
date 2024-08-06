//
//  CityViewController.swift
//  TravelMagazine
//
//  Created by 홍정민 on 5/29/24.
//

import UIKit
import RxSwift
import RxCocoa

final class CityViewController: UIViewController {
    @IBOutlet var citySearchBar: UISearchBar!
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var cityTableView: UITableView!
    
    let viewModel = CityViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("인기 도시")
        configureTableView()
        configureSegment()
        configureSearchBar()
        bindData()
    }
    
    func bindData(){
        let input = CityViewModel.Input(
            segmentTap: citySegment.rx.selectedSegmentIndex,
            searchText: citySearchBar.rx.text
        )
        
        let output = viewModel.transform(input: input)
        
        output.list
            .bind(to: cityTableView.rx.items(cellIdentifier: CityTableViewCell.reuseIdentifier, cellType: CityTableViewCell.self)){ (row, element, cell) in
                cell.configureData(data: element)
            }
            .disposed(by: disposeBag)
        
        output.segmentTap
            .map { _ in output.list.value.count > 0 }
            .bind(with: self) { owner, value in
              print(value)
                owner.cityTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
            .disposed(by: disposeBag)
    }
}

extension CityViewController {
    private func configureTableView(){
        cityTableView.rowHeight = 150
        cityTableView.separatorStyle = .none
        cityTableView.keyboardDismissMode = .onDrag
        
        let nib = UINib(nibName: CityTableViewCell.reuseIdentifier, bundle: nil)
        cityTableView.register(nib, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
    }
    
    private func configureSegment(){
        let title = Observable.from(["전체", "국내", "해외"])
        
        title.enumerated()
            .bind(with: self, onNext: { owner, value in
                let titleText = Observable.just(value.element)
                
                titleText
                    .bind(to: owner.citySegment.rx.titleForSegment(at: value.index))
                    .disposed(by: owner.disposeBag)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureSearchBar(){
        citySearchBar.searchTextField.tintColor = .black
        citySearchBar.searchTextField.placeholder = "도시를 입력해주세요"
    }
    
}
