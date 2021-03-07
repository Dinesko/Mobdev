//
//  Movies.swift
//  Mobdev
//
//  Created by Denis on 07.03.2021.
//

import Foundation

struct Movies: Codable {
    
    var items: [Movie]
    
    enum CodingKeys: String, CodingKey {
        
        case items = "Search"
    }
}
