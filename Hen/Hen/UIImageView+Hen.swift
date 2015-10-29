//
//  UIImageView+Hen.swift
//  Hen
//
//  Created by Hen Levy on 29/10/2015.
//  Copyright © 2015 Hen Levy. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    public func setImageFromStrURL(strUrl: String?, placeholder: UIImage? = nil, cacheCountLimit: Int = 0, maxOperationCount: Int = 0) {
        
        Hen.sharedInstance.fetchImage(self, strUrl: strUrl, placeholder: placeholder, countLimit: cacheCountLimit, operationCount: maxOperationCount)
    }
}
