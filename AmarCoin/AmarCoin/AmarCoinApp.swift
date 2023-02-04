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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
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
