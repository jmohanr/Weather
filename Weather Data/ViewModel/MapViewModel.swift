//
//  MapViewModel.swift
//  Weather Data
//
//  Created by Jagan on 11/02/20.
//  Copyright © 2020 Jagan. All rights reserved.
//

import UIKit
import MapKit
class MapViewModel: NSObject {
    var weatherData: WeatherData?
    
    func fetchingWeather(lat:Double,long:Double,mapView:MKMapView){
        NetWork.getDataWith(lat: lat, long: long) { (result) in
            switch result {
            case .Success(let data):
                self.weatherData = data
                self.addAnnotations(lat: lat, lon: long, mapView: mapView )
            case .Error(let message):
                print("\(message)")
            }
        }
    }
    
    func addAnnotations(lat:Double,lon:Double,mapView:MKMapView) {
               mapView.removeAnnotations(mapView.annotations)
           let appleParkAnnotation = MKPointAnnotation()

        appleParkAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat , longitude:lon)
        mapView.addAnnotation(appleParkAnnotation)
        self.zoomToLatestLocation(with: appleParkAnnotation.coordinate, mapView: mapView)
       }
    
     func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D,mapView:MKMapView) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(zoomRegion, animated: true)
    }
   
    func displayingData()->String{
        let markerData = """
        Area Name : \(self.weatherData?.name ?? "")
        Temperature : \(self.weatherData?.main.temp ?? 0) °F
        Weather Condition : \(self.weatherData?.weather[0].description ?? "")
        Wind Speed : \(self.weatherData?.wind.speed ?? 0) Km/h
        Humidity : \(self.weatherData?.main.humidity ?? 0) %
        """
        return markerData
    }
}

