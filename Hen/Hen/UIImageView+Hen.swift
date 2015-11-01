//
//  UIImageView+Hen.swift
//  Hen
//
//  Created by Hen Levy on 29/10/2015.
//  Copyright © 2015 Hen Levy. All rights reserved.
//

import UIKit

// Declare a global var to produce a unique address as the assoc object handle
var AssociatedObjectHandle: UInt8 = 0

public extension UIImageView {
    
    var id: String {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? String ?? ""
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy(rawValue: 1)!)
        }
    }
    
    public func setImageFromStrURL(strUrl: String?, placeholder: UIImage? = nil) {

        Hen.sharedInstance.fetchImage(self, strUrl: strUrl, placeholder: placeholder)
    }
}
