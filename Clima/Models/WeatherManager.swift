//
//  WeatherManager.swift
//  Clima
//
//  Created by Ildar Garifullin on 15/02/2023.
//

import Foundation

struct WeatherManager {
    let wetherURL = "https://api.openweathermap.org/data/2.5/weather?appid=126ef348292249571d3396c0ac032a00&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(wetherURL)&q=\(cityName)"
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //Create a URL
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            
            //Give URLSession a task
            let task = session.dataTask(
                with: url,
                completionHandler: handle(data:response:error:))
            
            //Start the task
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
        
        
    }
}
