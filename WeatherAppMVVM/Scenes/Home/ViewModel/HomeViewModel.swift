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
    @Published var errorMessage: String = ""
    @Published var cityName = ""
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchWeather(lat: Double, lon: Double, excluded: String) {
        isLoading = true
        apiService.fetchWeather(lat: lat, lon: lon, excluded: excluded)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { forecast in
                self.forecast = forecast
            })
            .store(in: &cancellables)
    }
    
    func fetchCity(lat: Double, lon: Double) {
        apiService.fetchCity(lat: lat, lon: lon)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { cities in
                self.cityName = cities.first?.name ?? ""
            })
            .store(in: &cancellables)
    }

}
