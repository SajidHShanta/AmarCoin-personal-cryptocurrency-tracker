//
//  ProtfolioDataService.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 7/2/23.
//

import Foundation
import CoreData

class ProtfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "ProtfolioContainer"
    private let entityName: String = "ProtfolioEntity"
    
    @Published var savedEntities: [ProtfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Erreor on loading Core Data. \(error)")
            }
            self.fetchProtfolio()
        }
    }
    
    private func fetchProtfolio() {
        let request = NSFetchRequest<ProtfolioEntity>(entityName: entityName)
    
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error on fetching Protfolio etities. \(error)")
        }
    }
    
    // MARK: Public functions
    
    func updateProtfolio(coin: CoinModel, ammount: Double) {
//        if let entity = savedEntities.first(where: { savedEntity in
//            savedEntity.coinID == coin.id
//        })
        
        //check if coin allready in protfolio
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){
            if ammount > 0 {
                update(entity: entity, ammount: ammount)
            } else {
                delete(entity: entity)
            }
        } else if ammount > 0{
            //coin is not in protfolio
            add(coin: coin, ammount: ammount)
        }
    }
    
    // MARK: Private functions
    
    private func add(coin: CoinModel, ammount: Double) {
        let entity = ProtfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.ammount = ammount
        applyChanges()
    }
    
    func update(entity: ProtfolioEntity, ammount: Double) {
        entity.ammount = ammount
        applyChanges()
    }
    
    func delete(entity: ProtfolioEntity) {
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
        fetchProtfolio()
    }
}
