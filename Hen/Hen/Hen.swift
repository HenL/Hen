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
    
    private var maxOperationCount: Int
    private var cacheCountLimit: Int
    
    private lazy var queue: NSOperationQueue = {
        var q = NSOperationQueue()
        q.maxConcurrentOperationCount = self.maxOperationCount
        return q
    }()
    
    private lazy var cache: NSCache = {
        var c = NSCache()
        c.countLimit = self.cacheCountLimit
        return c
    }()
    
    private init() {
        maxOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount
        cacheCountLimit = 0
    }
    
    func fetchImage(imageView: UIImageView!, strUrl: String?, placeholder: UIImage? = nil, countLimit: Int, operationCount: Int) {
        guard let stringUrl = strUrl else {
            imageView.image = placeholder
            return
        }
        if operationCount > 0 {
            maxOperationCount = operationCount
        }
        if countLimit > 0 {
            cacheCountLimit = countLimit
        }
        if let image = cache.objectForKey(stringUrl) as? UIImage {
            imageView.image = image
        } else {
            downloadImage(stringUrl, imageView: imageView)
        }
    }
    
    private func downloadImage(strUrl: String!, imageView: UIImageView!) {
        queue.addOperationWithBlock { [weak self, imageView, strUrl] in
            
            guard let strongSelf = self,
                destImageView = imageView,
                stringUrl = strUrl,
                imageData = NSData(contentsOfURL: NSURL(string: stringUrl)!),
                image = UIImage(data: imageData) else {
                return
            }
            strongSelf.cache.setObject(image, forKey: stringUrl)
            
            NSOperationQueue.mainQueue().addOperationWithBlock { [weak destImageView, image] in
                destImageView?.image = image
            }
        }
    }
}