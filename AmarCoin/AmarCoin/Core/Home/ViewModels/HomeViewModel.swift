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
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private let coinDataService = CoinDataServices()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
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
        
        // update portfolio Coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellebles)
        
        // update market Data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellebles)
    }
    
    func updatePortfolio(coin: CoinModel, ammount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, ammount: ammount)
    }
    
    // reload or refresh all data
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success) // vibrate 
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
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { coin in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.ammount)
            }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel]  {
        //converting marketDataModel to array of StatisticModel
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominence = StatisticModel(title: "BTC Dominence", value: data.btcDominance)
        
//        let portfolioValue =
//        portfolioCoins
//            .map { coin -> Double in
//                coin.currentHoldingsValue
//            }
//            .reduce(0, +)
        let portfolioValue = portfolioCoins.map({$0.currentHoldingsValue}).reduce(0, +)
        
        let previousPortfolioValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100  // ex: 45% = 45/100 = 0.5
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
        .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousPortfolioValue) / previousPortfolioValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.formattedWithAbbreviations(), percentageChange: percentageChange)
        
                        
        stats.append(contentsOf: [marketCap, volume, btcDominence, portfolio])
        
        return stats
    }
}
