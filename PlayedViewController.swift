//
//  PlayedViewController.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/15/25.
//

//
//  PlayedViewController.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/15/25.
//

import UIKit

class PlayedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!  // Connect this IBOutlet to your TableView in the storyboard
    
    var playedGames: [Game] {
            return GameManager.shared.playedGames
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GameCell")
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    }

    extension PlayedViewController: UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return playedGames.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
            let game = playedGames[indexPath.row]
            cell.textLabel?.text = game.name
            return cell
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let gameToDelete = playedGames[indexPath.row]
                GameManager.shared.playedGames.removeAll { $0.id == gameToDelete.id }
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    extension PlayedViewController: UITableViewDelegate {

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let game = playedGames[indexPath.row]
            print("Tapped on game: \(game.name)")

            let alertController = UIAlertController(title: "Add Review", message: "Write a review and rating for \(game.name)", preferredStyle: .alert)

            alertController.addTextField { textField in
                textField.text = game.review
                textField.placeholder = "Enter your review here"
            }

            alertController.addTextField { textField in
                if let rating = game.rating {
                    textField.text = "\(rating)"
                }
                textField.placeholder = "Enter rating (1-10)"
                textField.keyboardType = .numberPad
            }

            let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
                guard let review = alertController.textFields?[0].text,
                      let ratingText = alertController.textFields?[1].text,
                      let rating = Int(ratingText), (1...10).contains(rating) else { return }

                var updatedGame = game
                updatedGame.review = review
                updatedGame.rating = rating

                GameManager.shared.updatePlayedGame(at: indexPath.row, with: updatedGame)
                tableView.reloadData()
            }

            alertController.addAction(submitAction)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            present(alertController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }
