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
}

extension Movie {
    
    struct FiledValue {
        var field: String
        var value: String
    }
    
    var generatedFieldValues: [FiledValue] {
        return [
            FiledValue(field: "Title:", value: title),
            FiledValue(field: "Year:", value: year),
            FiledValue(field: "imdbID:", value: imdbID),
            FiledValue(field: "Type:", value: type),
            FiledValue(field: "Rated:", value: rated ?? "No info"),
            FiledValue(field: "Released:", value: released ?? "No info"),
            FiledValue(field: "Production:", value: production ?? "No info"),
            FiledValue(field: "Runtime:", value: runtime ?? "No info"),
            FiledValue(field: "Genre:", value: genre ?? "No info"),
            FiledValue(field: "Director:", value: director ?? "No info"),
            FiledValue(field: "Writer:", value: writer ?? "No info"),
            FiledValue(field: "Actors:", value: actors ?? "No info"),
            FiledValue(field: "Plot:", value: plot ?? "No info"),
            FiledValue(field: "Language:", value: language ?? "No info"),
            FiledValue(field: "Country:", value: country ?? "No info"),
            FiledValue(field: "Awards:", value: awards ?? "No info"),
            FiledValue(field: "imdbRating:", value: imdbRating ?? "No info"),
            FiledValue(field: "imdbVotes:", value: imdbVotes ?? "No info"),
        ]
    }
}
