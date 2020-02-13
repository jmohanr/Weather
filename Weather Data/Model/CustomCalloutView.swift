//
//  CustomCalloutView.swift
//  Weather Data
//
//  Created by Jagan on 12/02/20.
//  Copyright © 2020 Jagan. All rights reserved.
//

import UIKit
import MapKit

class CustomCalloutView: MKAnnotationView {
    @IBOutlet weak var name: UILabel!

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView != nil {
            superview?.bringSubviewToFront(self)
        }
        return hitView
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds
        var isInside = rect.contains(point)
        if !isInside {
            for view in subviews {
                isInside = view.frame.contains(point)
                if isInside {
                    break
                }
            }
        }
        return isInside
    }
}
