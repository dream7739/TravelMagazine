//
//  CityViewModel.swift
//  TravelMagazine
//
//  Created by 홍정민 on 7/9/24.
//

import Foundation

class CityViewModel{
    
    var segmentInput: Observable<Int> = Observable(1)
    var searchInput: Observable<String> = Observable("")
    var outputList: Observable<[City]> = Observable([])
    
    init(){
        segmentInput.bind { value in
            self.outputList.value = CityType.allCases[value].cityList
        }
        
        searchInput.bind { value in
            let keyword = value.trimmingCharacters(in: .whitespaces)
            
            if !keyword.isEmpty && value.koreanLangCheck() {
                self.fetchFilterList(keyword)
            }else if keyword.isEmpty{
                self.fetchList()
            }
        }
    }
    
    func fetchFilterList(_ input: String){
        outputList.value = CityInfo.city.filter{
            $0.city_name.localizedCaseInsensitiveContains(input) ||
            $0.city_english_name.localizedCaseInsensitiveContains(input) ||
            $0.city_explain.localizedCaseInsensitiveContains(input)
        }
    }
    
    func fetchList(){
        outputList.value = CityInfo.city
    }
}


