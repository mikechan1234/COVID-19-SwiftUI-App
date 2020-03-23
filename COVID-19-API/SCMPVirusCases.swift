//
//  SCMPVirusCases.swift
//  COVID-19-API
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import Foundation

struct SCMPVirusCases {
    
    var title: String
    var lastUpdated: Date
    var entries: [SCMPCountries]
    
}

// Codable Extension
extension SCMPVirusCases: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title, entries
        case lastUpdated = "last_updated"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        entries = try container.decode([SCMPCountries].self, forKey: .entries)
        
        let dateString = try container.decode(String.self, forKey: .lastUpdated)
        
        guard let date = DateFormatter.MMMdhmma.date(from: dateString) else {
            
            throw COVID19Error.formatting
            
        }
        
        lastUpdated = date
        
    }
    
}
