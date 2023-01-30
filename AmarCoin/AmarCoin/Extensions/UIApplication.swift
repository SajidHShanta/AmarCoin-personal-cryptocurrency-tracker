//
//  UIApplication.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 31/1/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    /// dismiss keyboard or end editing
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
