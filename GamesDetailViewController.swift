//
//  GamesDetailViewController.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/15/25.
//


import UIKit

class GamesDetailViewController: UIViewController {
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var addToWishlistButton: UIButton!
    @IBOutlet weak var addToPlayedButton: UIButton!
    
    var game: Game!  // The game object for the current game

    override func viewDidLoad() {
        super.viewDidLoad()

        // Ensure game is not nil
        guard let game = game else {
            showAlert(message: "Game details not available")
            return
        }

        // Set the game title label as the navigation title view
        let titleLabel = UILabel()
        titleLabel.text = game.name
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)  // Customize the font size as needed
        titleLabel.textColor = .black  // Customize the color as needed
        navigationItem.titleView = titleLabel

        // Set up the game image
        if let coverURL = game.coverURL {
            let fullURL = coverURL.hasPrefix("http") ? coverURL : "https:\(coverURL)"
            if let imageUrl = URL(string: fullURL) {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.gameImageView.image = image
                        }
                    }
                }.resume()
            }
        }

        // Set game title and description labels
        gameTitleLabel.text = game.name
        gameDescriptionLabel.text = game.summary

    }

    // Action for Add to Wishlist button
    @IBAction func addToWishlistTapped(_ sender: UIButton) {
        if let gameToAdd = game, !GameManager.shared.wishlistGames.contains(where: { $0.id == gameToAdd.id }) {
            GameManager.shared.addGameToWishlist(game: gameToAdd)
            showAlert(message: "Game added to Wishlist")
        } else {
            showAlert(message: "Game is already in the Wishlist")
        }
    }

    // Action for Add to Played button
    @IBAction func addToPlayedTapped(_ sender: UIButton) {
        if let gameToAdd = game, !GameManager.shared.playedGames.contains(where: { $0.id == gameToAdd.id }) {
            GameManager.shared.addGameToPlayed(game: gameToAdd)
            showAlert(message: "Game added to Played List")
        } else {
            showAlert(message: "Game is already in the Played List")
        }
    }

    // Show an alert message
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
