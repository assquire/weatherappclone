//
//  Constants.swift
//  WeatherAppClone
//
//  Created by Askar on 08.12.2022.
//

import Foundation
import UIKit

struct Constants {
    
    struct API {
        static let mainAddress = "https://open-meteo.com/en/docs#"
    }
    
    struct Identifiers {
        static let cityCell = "CityCell"
        static let hourlyForecastCell = "HourlyForecastCell"
        static let dailyForecastCell = "DailyForecastCell"
        static let descriptionCell = "DescriptionCell"
    }
    
    struct Colors {
        static let detailedViewBackground = UIColor(red: 63/255.0, green: 119/255.0, blue: 221/255.0, alpha: 1.0)
        static let collectionViewBorder = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        static let darkenBlue = UIColor(red: 124/255.0, green: 207/255.0, blue: 249/255.0, alpha: 1)
    }
    
}
