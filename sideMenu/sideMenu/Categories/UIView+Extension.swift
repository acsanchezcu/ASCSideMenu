//
//  UIView-Extension.swift
//  dynamicHeader
//
//  Created by Abel Sánchez Custodio on 20/2/16.
//  Copyright © 2016 acsanchezcu. All rights reserved.
//

import UIKit

extension UIView {
    
    class func embedView(view: UIView) {
        
        let views = ["view": view]
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        let heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        view.superview!.addConstraints(widthConstraints)
        view.superview!.addConstraints(heightConstraints)
    }
    
    class func embedViewWithSize(view: UIView, size: CGSize) {
        
        let views = ["view": view]
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[view(width)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["width": size.width], views: views)
        
        let heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[view(height)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["height": size.height], views: views)
        
        view.superview!.addConstraints(widthConstraints)
        view.superview!.addConstraints(heightConstraints)
    }
    
    class func embedView(view: UIView, size: CGSize, top: Bool, left: Bool, right: Bool, bottom: Bool) {
        
        let views = ["view": view]
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var metrics : Dictionary<String, CGFloat> = [:]
        
        //set horizontal visual format
        
        var horizontalVisualFormat = "H:"
        
        if left {
            horizontalVisualFormat += "|"
        }
        
        horizontalVisualFormat += "[view"
        
        if Float(size.width) > FLT_MIN {
            horizontalVisualFormat += "(width)"
            metrics["width"] = size.width
        }
        
        horizontalVisualFormat += "]"
        
        if right {
            horizontalVisualFormat += "|"
        }
        
        //set vertical visual format
        
        var verticalVisualFormat = "V:"
        
        if top {
            verticalVisualFormat += "|"
        }
        
        verticalVisualFormat += "[view"
        
        if Float(size.height) > FLT_MIN {
            verticalVisualFormat += "(height)"
            metrics["height"] = size.height
        }
        
        verticalVisualFormat += "]"
        
        if bottom {
            verticalVisualFormat += "|"
        }
        
        let widthConstraints = NSLayoutConstraint.constraintsWithVisualFormat(horizontalVisualFormat, options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat(verticalVisualFormat, options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        view.superview!.addConstraints(widthConstraints)
        view.superview!.addConstraints(heightConstraints)
    }
}
