//
//  GenreList.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 07.02.2024.
//

import Foundation

// MARK: - GenreList
struct GenreList: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
