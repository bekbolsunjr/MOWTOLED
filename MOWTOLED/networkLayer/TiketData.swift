//
//  TiketData.swift
//  MOWTOLED
//
//  Created by bekbolsun on 2023-07-12.
//

import Foundation

struct TiketData: Codable {
    let passengersCount: Int
    let origin, destination: Destination
    let results: [Tiket]

    enum CodingKeys: String, CodingKey {
        case passengersCount = "passengers_count"
        case origin, destination, results
    }
}

struct Destination: Codable {
    let iata, name: String
}

struct Tiket: Codable, Identifiable {
    let id, departureDateTime, arrivalDateTime: String
    let price: Price
    let airline: String
    let availableTicketsCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case departureDateTime = "departure_date_time"
        case arrivalDateTime = "arrival_date_time"
        case price, airline
        case availableTicketsCount = "available_tickets_count"
    }
}

struct Price: Codable {
    let currency: String
    let value: Int
}
