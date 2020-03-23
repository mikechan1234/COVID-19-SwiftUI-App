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

struct SCMPAPI {
    
    static private let session = URLSession(configuration: .default)
    static private let url = URL(string: "https://interactive-static.scmp.com/sheet/wuhan/viruscases.json")!
    
    static func getCases() -> AnyPublisher<SCMPVirusCases, Error> {
        
        return session.dataTaskPublisher(for: url).tryMap { (data, response) -> Data in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                
                throw COVID19Error.badRequest
                
            }
            
            return data
            
        }.decode(type: SCMPVirusCases.self, decoder: JSONDecoder()).eraseToAnyPublisher()
        
    }
    
}
