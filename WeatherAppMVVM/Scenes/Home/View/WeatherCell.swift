//
//  WeatherCell.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import SwiftUI

struct WeatherCell: View {
    @Environment(\.colorScheme) var colorScheme
    
    var cityName: String?
    var temperature: Double?
    var high: Double?
    var low: Double?
    var weatherDescription: String?
    var lastUpdated: String?
    
    var body: some View {
        HStack {
            // City Name and Additional Info
            VStack(alignment: .leading) {
                Text(cityName ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text("\(lastUpdated ?? "")")
                    .font(.caption)
                    .foregroundColor(.white)
                
                Spacer().frame(height: 10)
                Text(weatherDescription ?? "")
                    .font(.footnote)
                    .foregroundColor(.white)
                
            }
            
            Spacer()
            
            // Temperature
            VStack(alignment: .trailing) {
                HStack {
                    Text("\(String(format: "%.0f", temperature ?? 0)) °")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                }
                
                HStack {
                    Text("H:\(String(format: "%.0f", high ?? 0))°")
                        .font(.footnote)
                        .foregroundColor(.white)
                    Text("L:\(String(format: "%.0f", low ?? 0))°")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                
                
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color.gray.opacity(0.5): Color.gray)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct WeatherCell_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCell(
            cityName: "San Francisco",
            temperature: 22,
            high: 85,
            low: 78,
            weatherDescription: "Partly Cloudy",
            lastUpdated: "10:42"
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
