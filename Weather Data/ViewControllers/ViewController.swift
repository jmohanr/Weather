//
//  ViewController.swift
//  Weather Data
//
//  Created by Jagan on 11/02/20.
//  Copyright © 2020 Jagan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView:MKMapView!
    var locationManager = CLLocationManager()
    @IBOutlet var mapViewModel: MapViewModel!
    var matchingItems: [MKMapItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        mapView.showsUserLocation = true

    }
    
    //MARK:- Calling Api via selected data by using clouser call back
    @IBAction func searchArea(_ sender: UIButton) {
        if  let vc = storyboard?.instantiateViewController(identifier: "LocationSearchVC") as? LocationSearchVC {
            vc.fetchingSelectedData = { [weak self] (placeMark,searchedItems) in
                let isContainValue = self?.matchingItems.contains(searchedItems)
                if isContainValue == false {
                    self?.matchingItems.append(searchedItems)
                }
                self?.mapViewModel.fetchingWeather(lat: placeMark.coordinate.latitude, long: placeMark.coordinate.longitude, mapView:self?.mapView ?? MKMapView())
            }
            vc.recentSearch = self.matchingItems
            self.present(vc , animated: true, completion: nil)
        }
    }
    //MARK:- Zoom in  & Zoom out map action methods
    @IBAction func zoomInLocationButton(_ sender: UIButton) {
        mapView.setZoomByDelta(delta: 0.5, animated: true)
    }
    
    @IBAction func zoomOutLocationButton(_ sender: UIButton) {
        mapView.setZoomByDelta(delta: 2, animated: true)
    }
   
    //MARK:-Current user location action methods
    @IBAction func currentLocationButton(_ sender: UIButton) {
        self.mapViewModel.zoomToLatestLocation(with: mapView.userLocation.coordinate, mapView: mapView)
    }
}
//MARK:- Location manager delegate methods to update user current location
extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.mapViewModel.zoomToLatestLocation(with: location.coordinate, mapView: mapView)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}
//MARK:- Custom info methods  for marker
extension ViewController: MKMapViewDelegate {
    
     func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
           if view.annotation!.isKind(of: MKUserLocation.self){
               return
           }
        
        if let customView = (Bundle.main.loadNibNamed("CustomCalloutView", owner: self, options: nil))?[0] as? CustomCalloutView {
            customView.tag = 100
            let calloutViewFrame = customView.frame;
            customView.frame = CGRect(x: -view.frame.size.width/3, y: -calloutViewFrame.size.height-10, width: 200, height: 150)
            customView.name.text = self.mapViewModel.displayingData()
            customView.layer.borderWidth = 0.5
            customView.layer.borderColor = UIColor.black.cgColor
            customView.layer.cornerRadius = 5
            customView.layer.masksToBounds = true
            view.addSubview(customView)
         }
       }
       
       func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        for childView:AnyObject in view.subviews{
            if childView.tag == 100 {
              childView.removeFromSuperview()
            }
            
        }
    }
}



