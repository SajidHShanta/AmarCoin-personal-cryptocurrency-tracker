//
//  AmarCoinApp.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 20/1/23.
//

import SwiftUI

@main
struct AmarCoinApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true) //cause we will use custom header
            }
        }
    }
}
