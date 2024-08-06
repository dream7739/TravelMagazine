//
//  CityViewModel.swift
//  TravelMagazine
//
//  Created by 홍정민 on 7/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class CityViewModel{
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let segmentTap: ControlProperty<Int>
        let searchText: ControlProperty<String?>
    }
    
    struct Output {
        let segmentTap: ControlProperty<Int>
        let list: BehaviorRelay<[City]>
    }

    func transform(input: Input) -> Output {
        let list = BehaviorRelay(value: fetchList())
        
        input.segmentTap
            .bind(with: self) { owner, value in
                list.accept(CityType(rawValue: value)!.cityList)
            }
            .disposed(by: disposeBag)
        
        input.searchText
            .orEmpty
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, value in
                if !value.isEmpty && value.koreanLangCheck() {
                    list.accept(owner.fetchFilterList(value))
                }else{
                    list.accept(owner.fetchList())
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            segmentTap: input.segmentTap,
            list: list
        )
    }
    
}

extension CityViewModel {
    private func fetchFilterList(_ input: String) -> [City] {
        return CityInfo.city.filter {
            $0.city_name.localizedCaseInsensitiveContains(input) ||
            $0.city_english_name.localizedCaseInsensitiveContains(input) ||
            $0.city_explain.localizedCaseInsensitiveContains(input)
        }
    }
    
    private func fetchList() -> [City] {
        return CityInfo.city
    }
}
