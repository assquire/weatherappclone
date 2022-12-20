//
//  WeatherModel.swift
//  WeatherAppClone
//
//  Created by Askar on 14.12.2022.
//

import Foundation

struct WeatherModel {
    
    let time: String
    let cityName: String
    let conditionId: Int
    var conditionName: String {
        switch conditionId {
        case 800...804:
            return "cloud.bolt"
        case 800:
            return "sun.max"
        case 701...781:
            return "cloud.fog"
        case 600...622:
            return "cloud.snow"
        case 500...531:
            return "cloud.rain"
        case 300...321:
            return "cloud.drizzle"
        case 200...232:
            return "cloud.bolt.rain"
        default:
            return "cloud"
        }
    }
    let temperature: String
}
