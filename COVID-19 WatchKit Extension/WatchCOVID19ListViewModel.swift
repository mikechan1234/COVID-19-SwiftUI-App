//
//  WatchCOVID19ListViewModel.swift
//  COVID-19 WatchKit Extension
//
//  Created by michael.chan on 24/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import Combine
import COVID_19_API_watchOS
import SwiftUI

//Biggest downside in using @Published is that cannot be an subscriber

enum WatchCOVID19ListViewModelSortingTypes {
    
    case alphabetical
    case deaths
    case recovered
    
    var sort: ((SCMPCountry, SCMPCountry) -> Bool) {
        
        switch self {
            
        case .alphabetical:
            return {
                $0.name < $1.name
            }
        case .deaths:
            return {
                $0.deaths > $1.deaths
            }
        case .recovered:
            return {
                $0.recovered > $1.recovered
            }

        }
        
    }
    
}

class WatchCOVID19ListViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private var sortingType = CurrentValueSubject<WatchCOVID19ListViewModelSortingTypes, Never>(.deaths)
    
    var lastUpdated = CurrentValueSubject<String, Never>("")
    var totalCount = CurrentValueSubject<String, Never>("0")
    var deathCount = CurrentValueSubject<String, Never>("0")
    var recoveredCount = CurrentValueSubject<String, Never>("0")
    var countries = CurrentValueSubject<[SCMPCountry], Never>([])
    
    init() {
        
        cancellables.insert(countries.map { (countries) -> Int in
            
            countries.reduce(0) { (result, country) -> Int in
                
                result + country.cases
                
            }
            
        }.compactMap({ (value) -> String? in
            
            NumberFormatter.decimal.string(from: NSNumber(value: value))
            
        }).replaceNil(with: "").subscribe(totalCount))
        
        cancellables.insert(totalCount.sink { (count) in
            
            print("Total Count: \(count)")
            
        })
        
        cancellables.insert(countries.map { (countries) -> Int in
            
            countries.reduce(0) { (result, country) -> Int in
                
                result + country.deaths
                
            }
            
        }.compactMap({ (value) -> String? in
            
            NumberFormatter.decimal.string(from: NSNumber(value: value))
            
        }).replaceNil(with: "").subscribe(deathCount))
        
        cancellables.insert(countries.map { (countries) -> Int in
            
            countries.reduce(0) { (result, country) -> Int in
                
                result + country.recovered
                
            }
            
        }.compactMap({ (value) -> String? in
            
            NumberFormatter.decimal.string(from: NSNumber(value: value))
            
        }).replaceNil(with: "").subscribe(recoveredCount))
        
        cancellables.insert(sortingType.sink {[unowned self] (type) in
            
            self.countries.value.sort(by: self.sortingType.value.sort)
            
        })
        
    }
    
//    @discardableResult
//    func getData() -> AnyCancellable {
//
//        return SCMPAPI.getCases().map {[weak self] (value) -> [SCMPCountry] in
//
//            guard let self = self else {
//                
//                return []
//                
//            }
//                  
//            return value.entries.filter { (country) -> Bool in
//                
//                country.cases > 0
//                
//            }.sorted(by: self.sortingType.value.sort)
//
//        }.catch { (error) -> Empty<[SCMPCountry], Never> in
//
//            //For now we won't handle the error
//            Empty<[SCMPCountry], Never>(completeImmediately: true)
//
//        }.subscribe(countries)
//
//    }
    
    func getData() {
        
        SCMPAPI.getCases {[weak self] (cases, error) in
            
            guard let self = self, error == nil, let virusCases = cases else {
                
                return
                
            }
            
            self.lastUpdated.send("Last Updated: \(DateFormatter.MMMdhmma.string(from: virusCases.lastUpdated))")
            
            let cases = virusCases.entries.filter({ (country) -> Bool in
                
                country.cases > 0
                
            }).sorted(by: self.sortingType.value.sort)
            
            self.countries.send(cases)
            
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
            
        }
        
    }
    
}

extension WatchCOVID19ListViewModel {
    
    func changeSorting(to type: WatchCOVID19ListViewModelSortingTypes) {
        
        sortingType.value = type
        objectWillChange.send()
        
    }
    
}
