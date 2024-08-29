//
//  WeatherDetail.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import SwiftUI

struct WeatherDetailView: View {
    @Binding var isPresented: Bool
    @State var offset: CGFloat = 0
    var forecast: Forecast? = nil
    var cityName = ""
    var topEdge: CGFloat
    var body: some View {
        ZStack{
            // Geometry Reader for getting height and width...
            GeometryReader{proxy in
                Image("sky")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            // Blur Material...
            .overlay(.ultraThinMaterial)
            // Main View....
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    // Weather Data...
                    VStack(alignment: .center, spacing: 5) {
                        Text(cityName)
                            .font(.system(size: 35))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                        
                        Text("\(String(format: "%.0f", forecast?.current?.temperature ?? 0))°")
                            .font(.system(size: 45))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpactiy())
                        
                        Text(forecast?.current?.weather?.first?.description ?? "")
                            .foregroundStyle(.secondary)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpactiy())
                        
                        Text("H:\(String(format: "%.0f", forecast?.daily?.first?.temperature?.max ?? 0))° L:\(String(format: "%.0f", forecast?.daily?.first?.temperature?.min ?? 0))°")
                            .foregroundStyle(.primary)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpactiy())
                    }
                    .offset(y: -offset)
                    // For Bototm Drag Effect...
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: getTitleOffset())
                    
                    // Custom Data View...
                    VStack(spacing: 8){
                        // Custom Stack....
                        CustomStackView {
                            // Label Here....
                            Label {
                                Text("Hourly Forecast")
                            } icon: {
                                Image(systemName: "clock")
                            }
                        } contentView: {
                            // Content...
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 15){
                                    if let hourly = forecast?.hourly {
                                        ForEach(hourly) { hour in
                                            HourlyForecastView(time: "\(hour.currentTime?.hour() ?? "")",
                                                               farenheit: hour.temperature ?? 0,
                                                               image: hour.weather?.first?.weatherIconURL?.absoluteString ?? "")
                                        }
                                    }
                                }
                            }
                        }
                        WeatherDataView(forecast: forecast)
                    }
                }
                .padding(.top,25)
                .padding(.top,topEdge)
                .padding(.bottom, 70)
                .padding([.horizontal,.bottom])
                // getting Offset....
                .overlay(
                    // Using Geometry Reader....
                    GeometryReader{proxy -> Color in
                        let minY = proxy.frame(in: .global).minY
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        return Color.clear
                    }
                )
            }
            
            // Sticky Footer
            VStack {
                Spacer() // Push the footer to the bottom
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .padding()
                            .foregroundColor(Color.white.opacity(0.9))
                            .foregroundColor(.white)
                    }
                }
                .background(Color.black.opacity(0.1))
                .shadow(radius: 5)
                .padding(.bottom, 10)
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            print("weather detailView opened")
        }
    }
    
    func getTitleOpactiy()->CGFloat{
        let titleOffset = -getTitleOffset()
        let progress = titleOffset / 20
        let opacity = 1 - progress
        return opacity
    }
    
    func getTitleOffset()->CGFloat{
        // setting one max height for whole title...
        // consider max as 120....
        if offset < 0{
            let progress = -offset / 120
            // since top padding is 25....
            let newOffset = (progress <= 1.0 ? progress : 1) * 20
            return -newOffset
        }
        return 0
    }
}


struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{proxy in
            let topEdge = proxy.safeAreaInsets.top
            WeatherDetailView(isPresented: .constant(false), topEdge: topEdge)
        }
    }
}




