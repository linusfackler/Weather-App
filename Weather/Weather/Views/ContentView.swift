//
//  ContentView.swift
//  Weather
//
//  Created by Linus Fackler on 2/27/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                }
                else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitute: location.longitude)
                            } catch {
                                print("Error getting weather :\(error)")
                            }
                        }
                }
            }
            else {
                if locationManager.isLoading {
                    LoadingView()
                }
                else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
            
        }
        .background(Color(hue: 0.539, saturation: 1.0, brightness: 1.0))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
