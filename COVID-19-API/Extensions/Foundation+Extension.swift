//
//  Foundation+Extension.swift
//  COVID-19-API
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    static var decimal: NumberFormatter {
            
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        return formatter
        
    }
    
}

extension DateFormatter {
    
    static var MMMdhmma: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, h:mm a"
        
        return formatter
        
    }
    
}
