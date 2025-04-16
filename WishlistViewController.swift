//
//  WishlistViewController.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/15/25.
//

import UIKit

class WishlistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var wishlistGames: [Game] = [] {
            didSet {
                tableView.reloadData() // Update the table when the array changes
            }
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self

            // Register a default cell (if you're not using a custom prototype)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GameCell")

            // Initial load of wishlist games
            wishlistGames = GameManager.shared.wishlistGames
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            wishlistGames = GameManager.shared.wishlistGames // Reload when returning to screen
        }
    }

    extension WishlistViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return wishlistGames.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let game = wishlistGames[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
            cell.textLabel?.text = game.name
            return cell
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Remove the game from the wishlist and update the table view
                let gameToDelete = wishlistGames[indexPath.row]
                GameManager.shared.wishlistGames.removeAll { $0.id == gameToDelete.id }

                // Update the local wishlistGames array
                wishlistGames.remove(at: indexPath.row)

                // Delete the row from the table view with an animation
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    extension WishlistViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let game = wishlistGames[indexPath.row]
            print("Selected game from wishlist: \(game.name)")
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
