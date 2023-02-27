//
//  WeatherManager.swift
//  Weather
//
//  Created by Linus Fackler on 2/27/23.
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) async throws  {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitute)&appid=\("b679d88c220142171cc175460f2bc2c4")&units=metric") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        try JSONDecoder().decode(ResponseBody.self, from: data)
    }
}

struct ResponseBody: Decodable {
    
}
