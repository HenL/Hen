//
//  Hen.swift
//  Hen
//
//  Created by Hen Levy on 29/10/2015.
//  Copyright © 2015 Hen Levy. All rights reserved.
//

import Foundation

final class Hen {
    
    static let sharedInstance = Hen()
    
    private lazy var queue: NSOperationQueue = {
        return NSOperationQueue()
    }()
    
    private lazy var cache: NSCache = {
        return NSCache()
    }()
    
    var countLimit: Int {
        get {
            return cache.countLimit
        } set {
            cache.countLimit = newValue
        }
    }
    
    var totalCostLimit: Int {
        get {
            return cache.totalCostLimit
        } set {
            cache.totalCostLimit = newValue
        }
    }
    
    var maxOperationCount: Int {
        get {
            return queue.maxConcurrentOperationCount
        } set {
            queue.maxConcurrentOperationCount = newValue
        }
    }
    
    private init() {        
    }
    
    func fetchImage(imageView: HenImageView!, strUrl: String?, placeholder: UIImage? = nil) {
        guard let stringUrl = strUrl else {
            imageView.image = placeholder
            return
        }
        if let image = cache.objectForKey(stringUrl) as? UIImage {
            imageView.image = image
        } else {
            let id = NSUUID().UUIDString
            imageView.id = id
            downloadImage(stringUrl, imageView: imageView, id: id)
        }
    }
    
    private func downloadImage(strUrl: String!, imageView: HenImageView!, id: String!) {
        queue.addOperationWithBlock { [weak self, imageView, strUrl] in
            
            guard let strongSelf = self,
                destImageView = imageView,
                stringUrl = strUrl,
                imageData = NSData(contentsOfURL: NSURL(string: stringUrl)!),
                image = UIImage(data: imageData) else {
                return
            }
            strongSelf.cache.setObject(image, forKey: stringUrl)
            
            NSOperationQueue.mainQueue().addOperationWithBlock { [weak destImageView, image, id] in
                if destImageView?.id == id {
                    destImageView?.image = image
                }
            }
        }
    }
}