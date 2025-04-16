//
//  ReviewsViewController.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/15/25.
//

import UIKit

class ReviewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var reviewedGames: [Game] {
            // Filter games that have a review
            return GameManager.shared.playedGames.filter { $0.review != nil }
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
    }

    extension ReviewsViewController: UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return reviewedGames.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)

            let game = reviewedGames[indexPath.row]
            
            // Configure the cell with both game name and review
            let reviewText = game.review ?? "No review"
            cell.textLabel?.numberOfLines = 0  // Allow for multi-line text
            cell.textLabel?.text = "\(game.name)\nReview: \(reviewText)" // Display both game name and review text

            return cell
        }
    }

    extension ReviewsViewController: UITableViewDelegate {

        // You can handle tap actions here, for example, to edit the review
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let game = reviewedGames[indexPath.row]
            print("Tapped on game: \(game.name)")


            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
