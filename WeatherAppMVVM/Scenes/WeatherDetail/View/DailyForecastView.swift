//
//  DailyForecastView.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import SwiftUI

struct DailyForecastView: View {
    var daily: [DailyWeather]
    @StateObject private var imageDownloader = ImageDownloader()

    var body: some View {
        CustomStackView {
            Label {
                Text("Daily Forecast")
            } icon: {
                Image(systemName: "calendar")
            }
        } contentView: {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(daily) { day in
                    VStack {
                        HStack(spacing: 15){
                            Text(day.currentTime?.dayWord() ?? "")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                            // max widht...
                                .frame(width: 60,alignment: .leading)
                            
                            if let image = imageDownloader.downloadedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30)
                            } else {
                                ProgressView()
                                    .onAppear {
                                        imageDownloader.downloadImage(from: day.weather?.first?.weatherIconURL?.absoluteString)
                                    }
                            }
                            
                            Text("\(Int(day.temperature?.min ?? 0))")
                                .font(.title3.bold())
                                .foregroundStyle(.secondary)
                                .foregroundStyle(.white)
                            
                            // Progress Bar....
                            ZStack(alignment: .leading) {
                                
                                Capsule()
                                    .fill(.tertiary)
                                    .foregroundStyle(.white)
                                
                                // for width...
                                GeometryReader{proxy in
                                    
                                    Capsule()
                                        .fill(.linearGradient(.init(colors: [.orange,.red]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: ((day.temperature?.day ?? 1) / 140) * proxy.size.width)
                                }
                            }
                            .frame(height: 4)
                            
                            Text("\(Int(day.temperature?.max ?? 0))˚")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                        }
                        Divider()
                    }
                    .padding(.vertical,8)
                }
            }
        }
    }
}

#Preview {
    DailyForecastView(daily: [])
}
