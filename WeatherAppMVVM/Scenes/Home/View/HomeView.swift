//
//  HomeView.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var locationManager = LocationManager()
    @State private var location: String = ""
    @State private var isFullScreenPresented = false
    @State private var weatherDataRequested = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text("Weather")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        TextField("Search City", text: $location)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(colorScheme == .dark ? Color.gray.opacity(0.3) : Color.gray.opacity(0.2))
                            )
                        Button {
                            getWeatherForecast(for: location)
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title2)
                        }
                    }
                    
                    Spacer().frame(height: 20)
                    if let forecast = self.viewModel.forecast {
                        VStack(alignment: .leading) {
                            WeatherCell(cityName: self.viewModel.cityName,
                                        temperature: forecast.current?.temperature ?? 0,
                                        high: forecast.daily?.first?.temperature?.max ?? 0,
                                        low: forecast.daily?.first?.temperature?.min ?? 0,
                                        weatherDescription: forecast.current?.weather?.first?.description,
                                        lastUpdated: forecast.current?.currentTime?.hourMinute())
                            .onTapGesture {
                                isFullScreenPresented.toggle()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            // Loader as an overlay
            if viewModel.isLoading && viewModel.forecast == nil {
                Color.black.opacity(0.2) // Optional dimming effect
                    .ignoresSafeArea()
                
                VStack {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            self.checkIfLocationPresented()
        }
        .onReceive(locationManager.$location) { location in
            self.checkIfLocationPresented()
        }
        .onReceive(viewModel.$cityName) { cityName in
            ViewHelper.shared.saveCity(cityName)
        }
        .fullScreenCover(isPresented: $isFullScreenPresented) {
            GeometryReader{proxy in
                let topEdge = proxy.safeAreaInsets.top
                WeatherDetailView(isPresented: $isFullScreenPresented,
                                  forecast: self.viewModel.forecast,
                                  cityName: self.viewModel.cityName,
                                  topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
            }
        }
        .alert(isPresented: $viewModel.isAlertVisible) {
            showAlert(title: viewModel.alertTitle, message: viewModel.alertMessage)
        }
    }
    
    private func checkIfLocationPresented() {
        guard self.weatherDataRequested == false else { return }
        if let storedLocation = ViewHelper.shared.getStoredLocation() {
            self.fetchCurrentWeatherData(lat: storedLocation.lat, lon: storedLocation.lon)
            delay(1) {
                self.fetchCityName(lat: storedLocation.lat, lon: storedLocation.lon)
            }
        } else if let location = locationManager.location {
            self.fetchCurrentWeatherData(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            delay(1) {
                self.fetchCityName(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            }
        } else if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestLocation()
        }
    }
    
    func getWeatherForecast(for location: String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if error != nil {
                showWrongCityInputAlert()
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                self.viewModel.cityName = location
                ViewHelper.shared.saveLocation(LocationData(lat: lat, lon: lon))
                self.fetchCurrentWeatherData(lat: lat, lon: lon)
            }
        }
    }
    
    private func showWrongCityInputAlert() {
        self.viewModel.alertTitle = "Wrong city name"
        self.viewModel.alertMessage = "Please enter correct city name"
        self.viewModel.isAlertVisible = true
    }
    
    func fetchCurrentWeatherData(lat: Double, lon: Double) {
        self.weatherDataRequested = true
        UIApplication.shared.hideKeyboard()
        self.viewModel.fetchWeather(lat: lat, lon: lon, excluded: "minutely")
    }
    
    func fetchCityName(lat: Double, lon: Double) {
        if let cityName = ViewHelper.shared.getCityName(), !cityName.isEmpty {
            self.viewModel.cityName = cityName
        } else {
            self.viewModel.fetchCity(lat: lat, lon: lon)
        }
    }
}

extension HomeView {
    // MARK: Show Alerts
    func showAlert(title: String, message: String) -> Alert {
        Alert(title: Text(title),
              message: Text(message),
              dismissButton: .default(
                Text("OK"),
                action: {
                    print("Alert button cliked.")
                }
              )
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        HomeView(viewModel: viewModel)
        .previewLayout(.sizeThatFits)
        .padding()   
    }
}
