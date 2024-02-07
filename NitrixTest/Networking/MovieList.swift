//
//  MovieList.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 05.02.2024.
//

import Foundation
import RealmSwift

// MARK: - MovieList
class MovieList: Object, Codable {
    @Persisted var page: Int?
     var results = List<Movie>()
    @Persisted var totalPages: Int
    @Persisted var totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    required override init() {
            super.init()
        }
    
    init(page: Int? = nil, results: [Movie], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results.append(objectsIn: results)
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

// MARK: - Movie
class Movie: Object, Codable {
    @Persisted var backdropPath: String
    @Persisted var genreIDS: List<Int>
    @Persisted var id: Int
    @Persisted var originalTitle: String
    @Persisted var overview: String
    @Persisted var posterPath: String
    @Persisted var releaseDate: String
    @Persisted var title: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
    
    required override init() {
            super.init()
        }
    
    init(backdropPath: String, genreIDS: List<Int> , id: Int, originalTitle: String, overview: String, posterPath: String, releaseDate: String, title: String) {
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
    }
}
