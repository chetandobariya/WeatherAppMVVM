//
//  Weather.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation

struct Weather {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    var weatherIconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(icon ?? "")@2x.png")
    }
}

extension Weather: Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case id, main, description, icon
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? values.decode(Int.self, forKey: .main))
        self.main = (try? values.decode(String.self, forKey: .main))
        self.description = (try? values.decode(String.self, forKey: .description))
        self.icon = (try? values.decode(String.self, forKey: .icon))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.main, forKey: .main)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.icon, forKey: .icon)
    }
}
