//
//  HomeViewModel.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var forecast: Forecast?
    @Published var alertMessage: String = ""
    @Published var isAlertVisible = false
    @Published var alertTitle = ""
    @Published var cityName = ""
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchWeather(lat: Double, lon: Double, excluded: String) {
        guard NetworkReachability.shared.isNetworkAvailable() else {
            self.alertMessage = "No Internet Connection"
            self.isLoading = false
            return
        }
        isLoading = true
        apiService.fetchWeather(lat: lat, lon: lon, excluded: excluded)
            .receive(on: DispatchQueue.main) // Ensure this is on the main thread
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { forecast in
                self.forecast = forecast
            })
            .store(in: &cancellables)
    }
    
    func fetchCity(lat: Double, lon: Double) {
        guard NetworkReachability.shared.isNetworkAvailable() else {
            self.alertMessage = "No Internet Connection"
            self.isLoading = false
            return
        }
        apiService.fetchCity(lat: lat, lon: lon)
            .receive(on: DispatchQueue.main) // Ensure this is on the main thread
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { cities in
                self.cityName = cities.first?.name ?? ""
            })
            .store(in: &cancellables)
    }
    
}
