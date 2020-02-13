//
//  DataModel.swift
//  Weather Data
//
//  Created by Jagan on 11/02/20.
//  Copyright © 2020 Jagan. All rights reserved.
//

import Foundation
import MapKit

struct WeatherData:Decodable {
    var coord:Coordinates
    var weather:[Weather]
    var name:String
    var main:Main
    var base:String
    var wind:Wind
    var clouds:Clouds
    
}
struct Coordinates:Decodable {
    var lon:Double
    var lat:Double
}
struct Weather:Decodable {
    var id:Int
    var main:String
    var description:String
}

struct Main:Decodable {
    var temp:Double
    var pressure:Int
    var humidity:Int
    var temp_min:Double
    var temp_max:Double
    var feels_like:Double
}

struct Wind:Decodable {
    var speed:Double
    var deg:Int
}
struct Clouds:Decodable {
    var all:Int
}
struct Sys:Decodable {
    var type:Int
    var id:Int
    var country:String
    var sunrise:Int
    var sunset:Int
}

struct SearchedData {
    var areaName:String
    var lat:Double
    var long:Double
}

extension MKMapView {

// delta is the zoom factor
// 2 will zoom out x2
// .5 will zoom in by x2

func setZoomByDelta(delta: Double, animated: Bool) {
    var _region = region;
    var _span = region.span;
    _span.latitudeDelta *= delta;
    _span.longitudeDelta *= delta;
    _region.span = _span;

    setRegion(_region, animated: animated)
}
}

