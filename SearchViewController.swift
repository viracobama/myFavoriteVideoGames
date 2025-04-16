//
//  SearchViewController.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/9/25.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {


    @IBOutlet weak var gamesTableView: UITableView!
    @IBOutlet weak var gameSearchBar: UISearchBar!
    
    let gamesFetcher = GameFetcher()
        var incomingGames: [Game] = []
        var selectedGame: Game?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            gamesTableView.dataSource = self
            gamesTableView.delegate = self
            
            // Register your custom table view cell
            gamesTableView.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
            
            // Set up search bar delegate
            gameSearchBar.delegate = self
            
            gamesTableView.estimatedRowHeight = 100
            gamesTableView.rowHeight = UITableView.automaticDimension

        }
        
        // MARK: - SearchBar Delegate Method (Live Search)
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Only perform search if the text is not empty
            guard !searchText.isEmpty else {
                incomingGames.removeAll()
                gamesTableView.reloadData()
                return
            }
            
            gamesFetcher.getAllGames(input: searchText) { newGames in
                DispatchQueue.main.async {
                    self.incomingGames = newGames
                    self.gamesTableView.reloadData()
                }
            }
        }
        
        // MARK: - TableView Data Source
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return incomingGames.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GamesTableViewCell
            let game = incomingGames[indexPath.row]
            
            cell.gameNameLabel.text = game.name
            cell.gameImageView.image = nil // Reset in case reused

            // Load image asynchronously
            if let coverURL = game.coverURL {
                let fullURL = coverURL.hasPrefix("http") ? coverURL : "https://images.igdb.com\(coverURL)"
                if let imageUrl = URL(string: fullURL) {
                    URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                if let currentIndexPath = tableView.indexPath(for: cell),
                                   currentIndexPath == indexPath {
                                    cell.gameImageView.image = image
                                }
                            }
                        }
                    }.resume()
                }
            }

            
            return cell
        }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameDetail",
           let indexPath = gamesTableView.indexPathForSelectedRow {
            let gameToShow = incomingGames[indexPath.row]
            let destinationController = segue.destination as! GamesDetailViewController
            destinationController.game = gameToShow
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showGameDetail", sender: self)
    }



}
