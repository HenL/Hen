//
//  UIImageView+Hen.swift
//  Hen
//
//  Created by Hen Levy on 29/10/2015.
//  Copyright © 2015 Hen Levy. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    var id: String? {
        get {
            return self.id
        } set {
            self.id = newValue
        }
    }
    
    public func setImageFromStrURL(strUrl: String?, placeholder: UIImage? = nil) {
        
        Hen.sharedInstance.fetchImage(self, strUrl: strUrl, placeholder: placeholder)
    }
}
