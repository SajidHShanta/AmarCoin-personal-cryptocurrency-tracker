//
//  LocalFileManager.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 30/1/23.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    // make the initializer private, so that it can be initialized only inside the class
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        //create folder
        createFolderIfNotExists(folderName: folderName)
        
        // get psth for image
        guard let data = image.pngData(),
        let url = getImageURL(imageName: imageName, folderName: folderName)
        else { return }
        
        //save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error in saving '\(imageName)' Image: \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getImageURL(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path())
        else { return nil}
        
        return UIImage(contentsOfFile: url.path())
    }
    
    private func createFolderIfNotExists(folderName: String) {
        guard let url = getFolderURL(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
            } catch let error {
                print("Error in Creating '\(folderName)' Folder: \(error)")
            }
        }
    }
    
    private func getFolderURL(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
         
        return url.appendingPathComponent(folderName)
    }
    
    private func getImageURL(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getFolderURL(folderName: folderName) else { return nil }
        
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
