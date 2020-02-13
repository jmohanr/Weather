//
//  CalloutView.swift
//  Weather Data
//
//  Created by Jagan on 12/02/20.
//  Copyright © 2020 Jagan. All rights reserved.
//

import UIKit
import MapKit
class ExampleCalloutView: UIView {
    weak var annotation: MKAnnotation?

    @IBOutlet weak var areaNameLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init(annotation: MKAnnotation) {
           self.annotation = annotation
           super.init(frame: .zero)
        updateContents(for: annotation)

       }
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("Should not call init(coder:)")
    }
    private func updateContents(for annotation: MKAnnotation) {
    
    }
    func add(to annotationView: MKAnnotationView) {
        annotationView.addSubview(self)
        
        // constraints for this callout with respect to its superview
        
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: annotationView.topAnchor, constant: annotationView.calloutOffset.y),
            centerXAnchor.constraint(equalTo: annotationView.centerXAnchor, constant: annotationView.calloutOffset.x)
        ])
    }
}
