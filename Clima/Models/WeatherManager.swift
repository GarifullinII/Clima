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
        print(urlString)
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //Create a URL
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            
            //Give URLSession a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
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
            
            print(weater.temperatureString)
        } catch {
            print(error)
        }
    }
}
