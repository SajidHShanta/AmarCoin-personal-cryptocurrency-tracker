//
//  Double.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 24/1/23.
//

import Foundation

extension Double {
    /// Formatte a Double into currency with 2 to 6 decimal places
    /// ```
    /// Convert 1234.5678 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.12345678 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true // comma
        formatter.numberStyle = .currency
//        formatter.locale = .current // default value
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Formatte a Double into String currency with 2 to 6 decimal places
    /// ```
    /// Convert 1234.5678 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.12345678 to "$0.123456"
    /// ```
    func asCurrecyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Formatte a Double into formatted (%.2f) String
    /// ```
    /// Convert 1.234 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Formatte a Double into formatted (%.2f)+"%"  String with percent symble
    /// ```
    /// Convert 1.234 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
