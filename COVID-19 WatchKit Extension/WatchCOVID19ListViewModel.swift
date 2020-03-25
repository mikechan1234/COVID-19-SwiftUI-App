//
//  WatchCOVID19ListViewModel.swift
//  COVID-19 WatchKit Extension
//
//  Created by michael.chan on 24/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import Combine
import COVID_19_API_watchOS

class WatchCOVID19ListViewModel: ObservableObject {
    
    var cancellables: Set<AnyCancellable> = []
    
    var totalCount = CurrentValueSubject<String, Never>("0")
    var deathCount = CurrentValueSubject<String, Never>("0")
    var recoveredCount = CurrentValueSubject<String, Never>("0")
    var countries = CurrentValueSubject<[SCMPCountry], Never>([])
    
    init() {
        
        cancellables.insert(countries.map { (countries) -> Int in
            
            countries.reduce(0) { (result, country) -> Int in
                
                result + country.cases
                
            }
            
        }.map { (value) in
            
            String(value)
            
        }.subscribe(totalCount))
        
        cancellables.insert(totalCount.sink { (count) in
            
            print("Total Count: \(count)")
            
        })
        
        cancellables.insert(countries.map { (countries) -> Int in
            
            countries.reduce(0) { (result, country) -> Int in
                
                result + country.deaths
                
            }
            
        }.map { (value) in
            
            String(value)
            
        }.subscribe(deathCount))
        
        cancellables.insert(countries.map { (countries) -> Int in
            
            countries.reduce(0) { (result, country) -> Int in
                
                result + country.recovered
                
            }
            
        }.map { (value) in
            
            String(value)
            
        }.subscribe(recoveredCount))
        
    }
    
//    @discardableResult
//    func getData() -> AnyCancellable {
//
//        return SCMPAPI.getCases().map { (value) -> [SCMPCountry] in
//
//            value.entries
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
            
            self.countries.send(virusCases.entries)
            
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
            
        }
        
    }
    
}
