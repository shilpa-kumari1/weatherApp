//
//  WeatherModel.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 03/09/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import Foundation

struct Weather: Codable {
    
    let weather: [WeatherElement]
    let main: Main
    let sys: Sys
    let name: String
    let cod: Int
    let timezone: Int
    
}
// MARK: - Main
struct Main: Codable {
    let temp: Double
    let pressure, humidity: Double
    let tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
    let sunrise, sunset: Double
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main = "main"
        case weatherDescription = "description"
        case icon
    }
}

//MARK: - 5 day forecast
struct FiveWeather : Codable {
    let cod : String
    let list : [List]
    let city : City
}
struct List : Codable {
  
    let main : Main
    let weather : [WeatherElement]
    let dt : Int
}
struct City : Codable {
    let name : String
}
    
    

