//
//  Foundation+Extension.swift
//  COVID-19-API
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    public static var decimal: NumberFormatter {
            
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        return formatter
        
    }
    
}

extension DateFormatter {
    
    public static var MMMdhmma: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, h:mm a"
        
        return formatter
        
    }
    
    static var longDateTime: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
//        2020-03-26T07:48:31.939Z
        
        return formatter
        
    }
    
}
