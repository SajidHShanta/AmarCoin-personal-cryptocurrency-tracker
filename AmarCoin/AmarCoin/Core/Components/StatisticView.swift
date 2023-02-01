//
//  StatisticView.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 1/2/23.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 5.0) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: stat.percentageChange ?? 0 < 0 ? 180 : 0))
                
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption.bold())
            }
            .foregroundColor(stat.percentageChange ?? 0 < 0 ? Color.theme.red : Color.theme.green)
            .opacity(stat.percentageChange != nil ? 1 : 0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.stat3)
    }
}
