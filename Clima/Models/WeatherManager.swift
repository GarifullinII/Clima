//
//  WeatherManager.swift
//  Clima
//
//  Created by Ildar Garifullin on 15/02/2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let wetherURL = "https://api.openweathermap.org/data/2.5/weather?appid=...&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(wetherURL)&q=\(cityName)"
        print(urlString)
        
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, logitude: CLLocationDegrees) {
        let urlString = "\(wetherURL)&lat=\(latitude)&lon=\(logitude)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //Create a URL
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            
            //Give URLSession a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(
                            self,
                            weather: weather)
                    }
                }
            }
            
            //Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            
            let weater = WeatherModel(
                conditionId: id,
                cityName: name,
                temperature: temp)
            
            return weater
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
