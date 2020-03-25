//
//  COVID19SummaryCountView.swift
//  COVID-19 WatchKit Extension
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import SwiftUI

struct COVID19SummaryCountView: View {
    
    @State var type: COVID19SummaryCountViewType = .total
    @Binding var count: String
    
    var body: some View {

        GeometryReader { proxy in
            
            VStack {

                Text(self.count).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .center).foregroundColor(self.type.fontColor).font(.largeTitle).lineLimit(1).minimumScaleFactor(0.5)
                .padding([.horizontal, .top], 10)

            Text(self.type.description).frame(maxWidth: .infinity, alignment: .center).foregroundColor(self.type.fontColor).padding([.bottom], 15).padding([.top], 0)

            }.background(self.type.backgroundColor).cornerRadius(10)
            
        }.frame(height: 90, alignment: .center)

    }
    
}

struct COVID19SummaryCountView_Previews: PreviewProvider {
    static var previews: some View {
//        COVID19SummaryCountView(type: .recovered, count: "10000")
        COVID19SummaryCountView(type: .recovered, count: .constant("10000"))
    }
}
