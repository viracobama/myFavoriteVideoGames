//
//  ReviewsViewController.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/15/25.
//

import UIKit


class ReviewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    // Variable for storing the current sort option
    var currentSortOption: ReviewSortOption = .alphabetical

    // Computed property for reviewed games
    var reviewedGames: [Game] {
        let filteredGames = GameManager.shared.playedGames.filter { $0.review != nil || $0.rating != nil }

        switch currentSortOption {
        case .alphabetical:
            return filteredGames.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .ratingHighToLow:
            return filteredGames.sorted { ($0.rating ?? 0) > ($1.rating ?? 0) }
        case .ratingLowToHigh:
            return filteredGames.sorted { ($0.rating ?? 0) < ($1.rating ?? 0) }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the table view data source and delegate
        tableView.dataSource = self
        tableView.delegate = self

        // Register the cell for the table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReviewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // Action for sorting the reviews
    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sort Reviews", message: "Choose a sort option", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Alphabetical", style: .default, handler: { _ in
            self.currentSortOption = .alphabetical
            self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Rating: High to Low", style: .default, handler: { _ in
            self.currentSortOption = .ratingHighToLow
            self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Rating: Low to High", style: .default, handler: { _ in
            self.currentSortOption = .ratingLowToHigh
            self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ReviewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewedGames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = reviewedGames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)

        // Display game name, rating, and review
        let ratingText = game.rating != nil ? "\(game.rating!)" : "No rating"
        let reviewText = game.review ?? "No review"

        cell.textLabel?.numberOfLines = 0  // Allow for multi-line text
        cell.textLabel?.text = """
        \(game.name)
        Rating: \(ratingText)
        Review: \(reviewText)
        """

        return cell

    }
}

// MARK: - UITableViewDelegate
extension ReviewsViewController: UITableViewDelegate {

    // Handle tapping on a row to edit a review
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = reviewedGames[indexPath.row]
        print("Tapped on game: \(game.name)")

        let alertController = UIAlertController(
            title: "Edit Review & Rating",
            message: "Update your review and rating for \(game.name)",
            preferredStyle: .alert
        )

        alertController.addTextField { textField in
            textField.text = game.review
            textField.placeholder = "Enter your review"
        }

        alertController.addTextField { textField in
            if let rating = game.rating {
                textField.text = "\(rating)"
            }
            textField.placeholder = "Enter rating (1-10)"
            textField.keyboardType = .numberPad
        }

        let submitAction = UIAlertAction(title: "Update", style: .default) { _ in
            guard let review = alertController.textFields?[0].text,
                  let ratingText = alertController.textFields?[1].text,
                  let rating = Int(ratingText), (1...10).contains(rating) else { return }

            // Find the correct index in GameManager's playedGames
            if let realIndex = GameManager.shared.playedGames.firstIndex(where: { $0.id == game.id }) {
                var updatedGame = game
                updatedGame.review = review
                updatedGame.rating = rating

                GameManager.shared.updatePlayedGame(at: realIndex, with: updatedGame)
                tableView.reloadData()
            }
        }

        alertController.addAction(submitAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
