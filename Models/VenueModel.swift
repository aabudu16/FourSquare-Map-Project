//
//  FourSquareModel.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

// MARK: - Venues
struct Venues: Codable {
    let meta: Meta?
    let response: Response?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?

}

// MARK: - Response
struct Response: Codable {
    let venues: [Venue]?
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
    let referralID: Int?
    let hasPerk: Bool?
    let venuePage: VenuePage?
    let categories: [Category]?
    let hasNoCategory = "This venue has no category"
    
    func returnCategory()->String{
        return categories?.first?.name ?? hasNoCategory
    }
    
    func returnFullAddress()->String{
        let address = location?.address ?? "No Address"
        let city = location?.city ?? "No City"
        let state = location?.state ?? "No State"
        let country = location?.country ?? "No Country"
        return """
        \(address)
        City: \(city)
        State: \(state)
        Country: \(country)
        """
    }
}

// MARK: - Categories
struct Category: Codable {
   let id: String
   let name: String
   let pluralName: String
   let shortName: String
   let primary: Bool
}

// MARK: - Provider
struct Provider: Codable {
    let name: String?
    let icon: ProviderIcon?
}

// MARK: - ProviderIcon
struct ProviderIcon: Codable {
    let iconPrefix: String?
    let sizes: [Int]?
    let name: String?

}

// MARK: - Location
struct Location: Codable {
    let address: String?
    let lat, lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let postalCode: String?
    let cc: String?
    let neighborhood: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]?
    let crossStreet: String?
}



// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: String?
    let lat, lng: Double?
}


// MARK: - VenuePage
struct VenuePage: Codable {
    let id: String?
}
