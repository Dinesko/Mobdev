//
//  Movie.swift
//  Mobdev
//
//  Created by Denis on 07.03.2021.
//

import UIKit

struct Movie: Codable {
    
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
    
    func getPosterImage() -> UIImage {
        
        if poster.isEmpty {
            return UIImage(systemName: "film.fill")!
        } else {
            return UIImage(named: poster)!
        }
    }
}
