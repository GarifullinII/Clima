//
//  WeatherData.swift
//  Clima
//
//  Created by Ildar Garifullin on 16/02/2023.
//

import UIKit

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
