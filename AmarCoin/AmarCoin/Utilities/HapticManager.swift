//
//  HapticManager.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 8/2/23.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
