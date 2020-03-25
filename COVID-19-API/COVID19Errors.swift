//
//  COVID-19-Errors.swift
//  COVID-19-API
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import Foundation

public enum COVID19Error: Error {
    
    case formatting
    case badRequest
    case unknown
    
}

extension COVID19Error: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
        case .formatting:
            return "Something went wrong during formatting"
        case .badRequest:
            return "HTTP response was not 200"
        case .unknown:
            return "Something happened that we don't know"
        }
        
    }
    
}
