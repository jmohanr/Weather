//
//  NetWorkClass.swift
//  Weather Data
//
//  Created by Jagan on 11/02/20.
//  Copyright © 2020 Jagan. All rights reserved.
//

import Foundation
class NetWork: NSObject {
    
    //MARK:- Get API call method
    enum Result<T> {
        case Success(T)
        case Error(String)
    }
    
    static func getDataWith(lat:Double,long:Double,completion: @escaping (Result<WeatherData>) -> Void) {
        
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&APPID=3a5edcd15576a17cdf175469a6372cd3"
        
        guard let url = URL(string: urlString) else { return completion(.Error("Invalid URL, we can't update your feed")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
            }
            do {
                 let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.Success(weather))
                    }
                
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
            }.resume()
    }
}
