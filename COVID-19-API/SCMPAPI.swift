//
//  SCMPAPI.swift
//  COVID-19-API
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import Foundation
import Combine

//https://interactive-static.scmp.com/sheet/wuhan/viruscases.json

public struct SCMPAPI {
    
    static private let session = URLSession(configuration: .default)
    static private let url = URL(string: "https://interactive-static.scmp.com/sheet/wuhan/viruscases.json")!
    
    static public func getCases() -> AnyPublisher<SCMPVirusCases, COVID19Error> {
        
        return session.dataTaskPublisher(for: url).tryMap { (data, response) -> Data in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                
                throw COVID19Error.badRequest
                
            }
            
            return data
            
        }.decode(type: SCMPVirusCases.self, decoder: JSONDecoder()).mapError { (error) -> COVID19Error in
            
            guard let covidError = error as? COVID19Error else {
                
                return .unknown
                
            }
            
            return covidError
            
        }.eraseToAnyPublisher()
        
    }
    
    static public func getCases(completion: ((SCMPVirusCases?, COVID19Error?)->())? = nil) {
        
        session.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                
                completion?(nil, .badRequest)
                return
                
            }
            
            guard let scmpVirus = try? JSONDecoder().decode(SCMPVirusCases.self, from: jsonData) else {
                
                completion?(nil, .formatting)
                return
                
            }
            
            completion?(scmpVirus, nil)
            
        }.resume()
        
    }
    
}
