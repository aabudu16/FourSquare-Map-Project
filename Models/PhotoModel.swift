//
//  PhotoModel.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/7/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import  UIKit
// MARK: - Cards

struct Cards:Codable {
    let meta: Meta1
    let response: Response1
}

// MARK: - Meta
struct Meta1:Codable {
    let code: Int
    let requestID: String
}

// MARK: - Response
struct Response1: Codable {
    let photos: Photos
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
    let items: [Item]
    let dupesRemoved: Int
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let createdAt: Int
    let source: Source
    let itemPrefix: String
    let suffix: String
    let width, height: Int
    let user: User
    let checkin: Checkin
    let visibility: String
    
    func getUserImage()->String{
      return "\(itemPrefix)original\(suffix)"
    }
}

// MARK: - Checkin
struct Checkin: Codable {
    let id: String
    let createdAt: Int
    let type: String
    let timeZoneOffset: Int
}

// MARK: - Source
struct Source: Codable {
    let name: String
    let url: String
}

// MARK: - User
struct User: Codable {
    let id, firstName, lastName, gender: String
    let photo: Photo
}

// MARK: - Photo
struct Photo: Codable {
    let photoPrefix: String
    let suffix: String
}
