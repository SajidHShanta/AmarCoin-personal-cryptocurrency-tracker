//
//  CoinImageService.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 29/1/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    private let fileManeger = LocalFileManager.instance
    private let folderName = "coin_images"

    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManeger.getImage(imageName: coin.id, folderName: folderName) {
            //retrived savedImage form file maneger
            self.image = savedImage
        } else {
            // else, download image
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {
            return
        }
        
        imageSubscription = NetworkingManager.dowload(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManeger.saveImage(image: downloadedImage, imageName: self.coin.id, folderName: self.folderName)
            })
    }
}
