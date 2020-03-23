//
//  Countries.swift
//  COVID-19-API
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import Foundation

//    "country": "Mainland China",
//    "cases": "81054",
//    "deaths": "3,261",
//    "recovered": "71,740",
//    "lastupdated": "Mar 23, 04.00am"

protocol SCMPCOVID19Entry {
        
    var name: String {get set}
    var cases: Int {get set}
    var deaths: Int {get set}
    var recovered: Int {get set}
    var lastUpdated: Date? {get set}
    var comments: String? {get set}
    
}

struct SCMPCountries: SCMPCOVID19Entry {
    
    var name: String
    var cases: Int
    var deaths: Int
    var recovered: Int
    var lastUpdated: Date?
    var comments: String?
    
}

//Codable Extension
extension SCMPCountries: Codable {
    
    enum CodingKeys: String, CodingKey {
     
        case name = "country"
        case cases
        case deaths
        case recovered
        case lastUpdated
        case comments
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let casesString = try container.decode(String.self, forKey: .cases)
        let deathsString = try container.decode(String.self, forKey: .deaths)
        let recoveredString = try container.decode(String.self, forKey: .recovered)
        
        name = try container.decode(String.self, forKey: .name)
        
        let decimalFormatter = NumberFormatter.decimal
        
        guard let casesInt = decimalFormatter.number(from: casesString) as? Int, let deathInt = decimalFormatter.number(from: deathsString) as? Int, let recoveredInt = decimalFormatter.number(from: recoveredString) as? Int else {
            
            throw COVID19Error.formatting
            
        }
        
        cases = casesInt
        deaths = deathInt
        recovered = recoveredInt
        
        if let lastUpdatedString = try? container.decode(String.self, forKey: .lastUpdated) {
            
            lastUpdated = DateFormatter.MMMdhmma.date(from: lastUpdatedString)
            
        }
            
        comments = try? container.decode(String.self, forKey: .comments)
        
    }
    
}
