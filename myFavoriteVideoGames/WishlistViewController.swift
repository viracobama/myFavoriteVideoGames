//
//  WishlistViewController.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/15/25.
//

import UIKit

class WishlistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var wishlistGames: [Game] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GameCell")
            wishlistGames = GameManager.shared.wishlistGames
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            wishlistGames = GameManager.shared.wishlistGames
            tableView.reloadData()
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showGameDetail",
               let detailVC = segue.destination as? GamesDetailViewController,
               let selectedGame = sender as? Game {
                detailVC.game = selectedGame
            }
        }
    }

    // MARK: - UITableViewDataSource
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
                let gameToDelete = wishlistGames[indexPath.row]

                // Update GameManager's data
                var currentGames = GameManager.shared.wishlistGames
                currentGames.removeAll { $0.id == gameToDelete.id }
                GameManager.shared.wishlistGames = currentGames

                // Update the local array BEFORE deleting the row
                wishlistGames.remove(at: indexPath.row)

                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    // MARK: - UITableViewDelegate
    extension WishlistViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedGame = wishlistGames[indexPath.row]
            performSegue(withIdentifier: "showGameDetail", sender: selectedGame)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
