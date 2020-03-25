//
//  SCMPVirusCases.swift
//  COVID-19-API
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import Foundation

public struct SCMPVirusCases {
    
    public var title: String
    public var lastUpdated: Date
    public var entries: [SCMPCountry]
    
}

// Codable Extension
extension SCMPVirusCases: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case entries
        case lastUpdated = "last_updated"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        entries = try container.decode([SCMPCountry].self, forKey: .entries)
        
        let dateString = try container.decode(String.self, forKey: .lastUpdated)
        
        guard let date = DateFormatter.longDateTime.date(from: dateString) else {
            
            throw COVID19Error.formatting
            
        }
        
        lastUpdated = date
        
    }
    
}
