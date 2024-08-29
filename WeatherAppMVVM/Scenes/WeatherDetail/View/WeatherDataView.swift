//
//  WeatherDataView.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import SwiftUI

struct WeatherDataView: View {
    var forecast: Forecast?
    
    var body: some View {
        
        VStack(spacing: 8){
            if let alert = forecast?.alerts?.first {
                CustomStackView {
                    Label {
                        Text(alert.event ?? "")
                    } icon: {
                        Image(systemName: "circle.hexagongrid.fill")
                    }
                    
                } contentView: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(alert.tags?.first ?? "")
                            .font(.title3.bold())
                        
                        Text(alert.description ?? "")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                }
            }
            
            HStack{
                CustomStackView {
                    Label {
                        Text("UV Index")
                    } icon: {
                        Image(systemName: "sun.min")
                    }
                } contentView: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(String(format: "%.0f", forecast?.current?.uvi ?? 0))%")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("Low")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
                }
                CustomStackView {
                    Label {
                        Text("Humidity")
                    } icon: {
                        Image(systemName: "drop.fill")
                    }
                } contentView: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(String(format: "%.0f", forecast?.current?.humidity ?? 0))%")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("in last 24 hours")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
                }
            }
            .frame(maxHeight: .infinity)
            
            if let daily = forecast?.daily {
               DailyForecastView(daily: daily)
            }
        }
    }
}


#Preview {
    WeatherDataView()
}
