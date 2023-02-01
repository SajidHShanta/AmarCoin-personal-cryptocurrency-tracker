//
//  StatisticModel.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 1/2/23.
//

import Foundation

class StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
