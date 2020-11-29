//
//  Movie.swift
//  test8200ac
//
//  Created by אילי זוברמן on 29/11/2020.
//

import Foundation
import SwiftDate

struct Movie: Identifiable, Codable{
    
    var id: Int
    var title: String
    var releaseDate: String
    var posterPath: String?
    var voteCount = 0
    var voteAverage: Double = 0
    var popularity: Double = 0
    var overview: String
}

struct MovieList: Codable{
    let page: Int
    let totalResults: Int?
    let totalPages: Int?
    let results: [Movie]
}
