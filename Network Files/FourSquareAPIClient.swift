//
//  FourSquareAPIClient.swift
//  FourSquare-Map_Project
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct FourSquareAPIClient{
    static let shared = FourSquareAPIClient()
    
    // getting venu data
    func getData(lat:Double, long:Double, query:String, complitionHandler:@escaping(Result<[Venue], AppError>)->()){
    let urlString = "https://api.foursquare.com/v2/venues/search?ll=\(lat),\(long)&client_id=\(Secret.clientID)&client_secret=\(Secret.clientSecrets)&query=\(query)&v=20191104"
        guard let url = URL(string: urlString) else {
            complitionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result{
            case .failure:
                complitionHandler(.failure(.noDataReceived))
            case .success(let data):
                do{
                    let venue = try JSONDecoder().decode(Venues.self, from: data)
                    complitionHandler(.success((venue.response?.venues)!))
                }catch{
                    complitionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    
    // getting venue immages
    
    func getVenueImages(venueID:String, complitionHandler:@escaping(Result<[Item], AppError>)->()){
        let urlString = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(Secret.clientID)&client_secret=\(Secret.clientSecrets)&v=20191104&limit=1"
        
        
        guard let url = URL(string: urlString) else {
            complitionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result{
            case .failure:
                complitionHandler(.failure(.noDataReceived))
            case .success(let data):
                do{
                    let imageString = try JSONDecoder().decode(Cards.self, from: data)
                    complitionHandler(.success(imageString.response.photos.items))
                }catch{
                    complitionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
}
