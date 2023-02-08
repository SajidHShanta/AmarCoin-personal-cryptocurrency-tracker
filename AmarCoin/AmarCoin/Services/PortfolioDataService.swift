//
//  PortfolioDataService.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 7/2/23.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Erreor on loading Core Data. \(error)")
            }
            self.fetchPortfolio()
        }
    }
    
    private func fetchPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
    
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error on fetching Portfolio etities. \(error)")
        }
    }
    
    // MARK: Public functions
    
    func updatePortfolio(coin: CoinModel, ammount: Double) {
//        if let entity = savedEntities.first(where: { savedEntity in
//            savedEntity.coinID == coin.id
//        })
        
        //check if coin allready in portfolio
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){
            if ammount > 0 {
                update(entity: entity, ammount: ammount)
            } else {
                delete(entity: entity)
            }
        } else if ammount > 0{
            //coin is not in portfolio
            add(coin: coin, ammount: ammount)
        }
    }
    
    // MARK: Private functions
    
    private func add(coin: CoinModel, ammount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.ammount = ammount
        applyChanges()
    }
    
    func update(entity: PortfolioEntity, ammount: Double) {
        entity.ammount = ammount
        applyChanges()
    }
    
    func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error on saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        fetchPortfolio()
    }
}
