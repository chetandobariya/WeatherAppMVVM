//
//  WeatherAlert.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation

struct WeatherAlert {
    var senderName: String?
    var event: String?
    var start: Date?
    var end: Date?
    var description: String?
    var tags: [String]?

}

extension WeatherAlert: Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case sender_name, event, start, end, description, tags
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.senderName = (try? values.decode(String.self, forKey: .sender_name))
        self.event = (try? values.decode(String.self, forKey: .event))
        self.start = (try? values.decode(Date.self, forKey: .start))
        self.end = (try? values.decode(Date.self, forKey: .end))
        self.description = (try? values.decode(String.self, forKey: .description))
        self.tags = (try? values.decode([String].self, forKey: .tags))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.senderName, forKey: .sender_name)
        try container.encode(self.event, forKey: .event)
        try container.encode(self.start, forKey: .start)
        try container.encode(self.end, forKey: .end)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.tags, forKey: .tags)

    }
}
