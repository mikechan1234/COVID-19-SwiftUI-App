//
//  WatchCOVID19ListView.swift
//  COVID-19 WatchKit Extension
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import SwiftUI

struct WatchCOVID19ListView: View {
    
    @State var fullPreview: Bool = false
    
    @ObservedObject var model = WatchCOVID19ListViewModel()
    
    var body: some View {
            
        ScrollView {
            
            VStack {
                
                COVID19SummaryCountView(type: .total, count: $model.totalCount.value)

                if fullPreview {
                
                    HStack(alignment: .center) {
                        
                        COVID19SummaryCountView(type: .deaths, count: $model.deathCount.value)

                        COVID19SummaryCountView(type: .recovered, count: $model.recoveredCount.value)
                        
                    }
                    
                } else {
                    
                    COVID19SummaryCountView(type: .deaths, count: $model.deathCount.value)

                    COVID19SummaryCountView(type: .recovered, count: $model.recoveredCount.value)
                    
                }
                
            }
            
        }.onAppear {
            
            self.model.getData()
            
        }
        
    }
    
}

struct WatchCOVID19ListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchCOVID19ListView()
    }
}
