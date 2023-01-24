//
//  AmarCoinApp.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 20/1/23.
//

import SwiftUI

@main
struct AmarCoinApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true) //cause we will use custom header
            }
            .environmentObject(vm)
        }
    }
}
