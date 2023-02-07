//
//  HomeViewModel.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 24/1/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var protfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataServices()
    private let marketDataService = MarketDataService()
    private let protfolioDataService = ProtfolioDataService()
    private var cancellebles = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // update allCoins
        $searchText
        .combineLatest(coinDataService.$allCoins)
        .debounce(for: 0.2, scheduler: DispatchQueue.main) // add 0.2 sec delay(time interval) before executing filter
        .map(filterCoins)
        .sink { [weak self] (returnedCoins) in
            self?.allCoins = returnedCoins
        }
        .store(in: &cancellebles)
        
        // update market Data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellebles)
        
        // update protfoio Coins
        $allCoins
            .combineLatest(protfolioDataService.$savedEntities)
            .map { (coinModels, protfolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap { coin in
                        guard let entity = protfolioEntities.first(where: {$0.coinID == coin.id}) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.ammount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.protfolioCoins = returnedCoins
            }
            .store(in: &cancellebles)
    }
    
    func updateProtfolio(coin: CoinModel, ammount: Double) {
        protfolioDataService.updateProtfolio(coin: coin, ammount: ammount)
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
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel]  {
        //converting marketDataModel to array of StatisticModel
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominence = StatisticModel(title: "BTC Dominence", value: data.btcDominance)
        let protfolio = StatisticModel(title: "Protfolio Value", value: "$0.00", percentageChange: 0) // will update this latter
        
                        
        stats.append(contentsOf: [marketCap, volume, btcDominence, protfolio])
        
        return stats
    }
}
