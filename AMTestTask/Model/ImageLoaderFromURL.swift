//
//  ImageLoader.swift
//  AMTestTask
//
//  Created by  Kostantin Zarubin on 07.07.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class ImageLoaderFromURL {
    private let cache = NSCache<NSString, NSData>()
    
    func image(for url: URL, completionHandler: @escaping(_ image: UIImage?) -> ()) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            if let data = self.cache.object(forKey: url.absoluteString as NSString) {
                DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
                return
            }
            guard let data = NSData(contentsOf: url) else {
                DispatchQueue.main.async { completionHandler(nil) }
                return
            }
            self.cache.setObject(data, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        }
    }
}
