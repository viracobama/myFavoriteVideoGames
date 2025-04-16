//
//  Games.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/9/25.
//

import Foundation

// The Cover struct, which holds information about the game's cover
struct Cover: Codable {
    let id: Int
    let url: String
}

// The Game struct, which represents a game and its properties
struct Game: Codable {
    let id: Int
    let name: String
    let summary: String?
    let cover: Cover?
    var rating: Int? // Add the rating property
    var review: String? // Add the review property
    
    var coverURL: String? {
        guard let url = cover?.url else { return nil }
        return url.hasPrefix("http") ? url : "https:\(url)"
    }
}
