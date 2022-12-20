//
//  WeatherManager.swift
//  WeatherAppClone
//
//  Created by Askar on 14.12.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(with weatherModels: [WeatherModel])
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    func fetchRequest(with cityLocation: (Double, Double)) {
        let urlString = "\(Constants.API.mainAddress)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                print(data)
                if let _ = parseJSON(data) {

                }
            } else {
                delegate?.didFailWithError(error: error!)
            }
        }
        task.resume()
    }
    
    func fetchRequest(with cityLocations: [(Double, Double)]) {
        var cityWeatherModels: [WeatherModel] = []
        for cityLocation in cityLocations {
            let urlString = "\(Constants.API.mainAddress)latitude=\(cityLocation.0)&longitude=\(cityLocation.1)&hourly=temperature_2m,weathercode&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset&timezone=Europe%2FMoscow"
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    if let model = parseJSON(data) {
                        cityWeatherModels.append(model)
                    }
                } else {
                    delegate?.didFailWithError(error: error!)
                }
            }
            print(cityWeatherModels)
            task.resume()
        }
        delegate?.didUpdateWeather(with: cityWeatherModels)
    }
    
    func parseJSON(_ data: Data) -> WeatherModel? {
        do {
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            let time = String(decodedData.data[0].ob_time.suffix(4))
            let cityName = decodedData.data[0].city_name
            let conditionID = decodedData.data[0].weather.code
            let temperature = String(decodedData.data[0].temp)
            let model = WeatherModel(time: time, cityName: cityName, conditionId: conditionID, temperature: temperature)
            return model
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


/*
 
 https://open-meteo.com/en/docs#latitude=43.26&longitude=76.93&hourly=temperature_2m,weathercode&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset&timezone=Europe%2FMoscow
 
 https://api.openweathermap.org/data/2.5/weather?q=London&appid=247397ddfbb7d87cfea09ab851c6e02f
 247397ddfbb7d87cfea09ab851c6e02f
 
 */
