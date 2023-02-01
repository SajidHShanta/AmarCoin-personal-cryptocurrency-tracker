//
//  HomeViewModel.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 24/1/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "title", value: "value", percentageChange: 2.3),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value", percentageChange: -4.2),
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var protfoioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataServices()
    private var cancellebles = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        //update allCoins
        $searchText
        .combineLatest(dataService.$allCoins)
        .debounce(for: 0.5, scheduler: DispatchQueue.main) // add 0.5 sec delay(time interval) before executing filter
        .map(filterCoins)
        .sink { [weak self] (returnedCoins) in
            self?.allCoins = returnedCoins
        }
        .store(in: &cancellebles)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText)
        }
    }
}
