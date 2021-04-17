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
    
    let rated, released, production: String?
    let runtime, genre, director, writer: String?
    let actors, plot, language, country: String?
    let awards, imdbRating, imdbVotes: String?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbID = "imdbID"
        case type = "Type"
        case production = "Production"
    }
    
    func getPosterImage() -> UIImage {
        
        if poster.isEmpty {
            return UIImage(systemName: "film.fill")!
        } else {
            return UIImage(named: poster)!
        }
    }
    
    var fullInfo: [(field: String, value: String)] {
        
        return [
            (field: "Title", value: title),
            (field: "Year", value: year),
            (field: "imdbID", value: imdbID),
            (field: "type", value: type),
            (field: "rated", value: rated ?? "No info"),
            (field: "released", value: released ?? "No info"),
            (field: "production", value: production ?? "No info"),
            (field: "runtime", value: runtime ?? "No info"),
            (field: "genre", value: genre ?? "No info"),
            (field: "director", value: director ?? "No info"),
            (field: "writer", value: writer ?? "No info"),
            (field: "actors", value: actors ?? "No info"),
            (field: "plot", value: plot ?? "No info"),
            (field: "language", value: language ?? "No info"),
            (field: "country", value: country ?? "No info"),
            (field: "awards", value: awards ?? "No info"),
            (field: "imdbRating", value: imdbRating ?? "No info"),
            (field: "imdbVotes", value: imdbVotes ?? "No info"),
        ]
    }
}
