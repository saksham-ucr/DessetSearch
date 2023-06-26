//
//  CacheManager.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/24/23.
//

import Foundation
import SwiftUI

protocol CacheLayer {
    func saveImage(image: UIImage, imageName: String, folderName: String)
    func getImage(imageName: String, folderName: String) -> UIImage?
    
}

/// Singleton class to enable caching for images in the filemanager
class CacheManager: CacheLayer{
    
    static let shared = CacheManager()
    
    private init() {}
    
    // MARK: SaveImage
    /// Saves an image in the cache
    ///
    /// First creates a directory, then builds url for the file where image needs to be saved and then tries to svae image
    ///
    /// - Parameter image: UIImage to be saved
    /// - Parameter imageName: Image Name, must be unique for all the images
    /// - Parameter folderName: Folder name under which all the images will be saved (usually app name)
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // Create folder
        self.createFolder(folderName: folderName)
        
        //Get Url
        guard
            let data = image.jpegData(compressionQuality: 0.8),
            let url = getUrlForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        // Save Image
        do{
            try data.write(to: url)
        } catch let err {
            print("Error saving image: \(err)")
        }
        
    }
    
    // MARK: GetImage
    /// Retrieves image from storage
    ///
    /// First builds the url and then returns the image
    ///
    /// - Parameter imageName: Name of the image to be retrieved
    /// - Parameter folderName: Name of the folder where the image is stored
    func getImage(imageName: String, folderName: String) -> UIImage?{
        
        guard
            let url = getUrlForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else {return nil}
        
        return UIImage(contentsOfFile: url.path)
    }
    
    
    // MARK: CreateFolder
    /// Creates folder
    ///
    /// First checks if a folder already exists and and creates if not
    ///
    ///- Parameter folderName: Name of the folder
    private func createFolder(folderName: String) {
        
        guard
            let url = getUrlForFolder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path) {
            
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true)
            } catch let error {
                print("Error \(error.localizedDescription) with \(folderName)")
            }
            
        }
    }
    
    // MARK: GetURLForFolder
    /// Gives URL for the folder
    ///
    ///- Parameter folderName: Name of the folder
    ///- Returns: URL for the directory in the cache
    private func getUrlForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else {return nil}
        
        return url.appendingPathComponent(folderName)
    }
    
    // MARK: GetURLForImage
    
    /// Function returns url for the image in the cache
    ///- Parameter imageName: name of the image
    ///- Parameter folderName: Name of the folder
    ///- Returns: URL where the is saved or is going to be saved
    private func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard
            let url = getUrlForFolder(folderName: folderName)
        else {return nil}
        
        return url.appendingPathComponent(imageName + ".jpg")
    }
}
