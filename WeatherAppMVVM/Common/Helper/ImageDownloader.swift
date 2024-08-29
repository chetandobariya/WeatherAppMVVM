//
//  ImageDownloader.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import SwiftUI
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getCachedImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func cacheImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

class ImageDownloader: ObservableObject {
    @Published var downloadedImage: UIImage?
    
    func downloadImage(from urlString: String?) {
        guard let urlString = urlString else { return }
        // Check if the image is already cached
        if let cachedImage = ImageCacheManager.shared.getCachedImage(forKey: urlString) {
            DispatchQueue.main.async {
                self.downloadedImage = cachedImage
            }
            return
        }

        // Download the image if it's not cached
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to convert data to image")
                return
            }
            // Cache the downloaded image
            ImageCacheManager.shared.cacheImage(image, forKey: urlString)

            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.downloadedImage = image
            }
        }.resume()
    }
}
