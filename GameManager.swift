//
//  GameManager.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/15/25.
//
import Foundation

class GameManager {
    static let shared = GameManager()

    private let wishlistKey = "wishlistGames"
    private let playedKey = "playedGames"

    var wishlistGames: [Game] {
        get {
            if let data = UserDefaults.standard.data(forKey: wishlistKey),
               let games = try? JSONDecoder().decode([Game].self, from: data) {
                return games
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: wishlistKey)
            }
        }
    }

    var playedGames: [Game] {
        get {
            if let data = UserDefaults.standard.data(forKey: playedKey),
               let games = try? JSONDecoder().decode([Game].self, from: data) {
                return games
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: playedKey)
            }
        }
    }

    private init() {}

    func updatePlayedGame(at index: Int, with updatedGame: Game) {
        var currentGames = playedGames
        currentGames[index] = updatedGame
        playedGames = currentGames
    }

    // New method to add a game to the wishlist
    func addGameToWishlist(game: Game) {
        var currentGames = wishlistGames
        if !currentGames.contains(where: { $0.id == game.id }) {
            currentGames.append(game)
            wishlistGames = currentGames
        }
    }

    // New method to add a game to the played games
    func addGameToPlayed(game: Game) {
        var currentGames = playedGames
        if !currentGames.contains(where: { $0.id == game.id }) {
            currentGames.append(game)
            playedGames = currentGames
        }
    }
}
