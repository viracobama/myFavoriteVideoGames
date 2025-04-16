//
//  GameFetcher.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/10/25.
//

//
//  GameFetcher.swift
//  myFavoriteVideoGames
//
//  Created by Virac Bou on 4/10/25.
//

import Foundation

class GameFetcher {
    
    // Fetches games based on a search term
    func getAllGames(input: String, completion: @escaping ([Game]) -> Void) {
        let url = URL(string: "https://igdb-proxy-cc7025ef17a0.herokuapp.com/search")! // Proxied endpoint
        var request = URLRequest(url: url)
        
        // Set the HTTP method to POST
        request.httpMethod = "POST"
        
        // Set headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare the JSON body with the search query
        let jsonBody: [String: Any] = [
            "searchTerm": input // You can also adjust this depending on the exact structure of the API
        ]
        
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
            request.httpBody = bodyData
        } catch {
            print("Error preparing request body: \(error)")
            completion([])  // Return an empty array in case of error
            return
        }
        
        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }

            // 👉 ADD THIS LINE BELOW TO PRINT THE RAW JSON:
            print(String(data: data, encoding: .utf8) ?? "Invalid JSON format")

            // Now decode it
            do {
                let games = try JSONDecoder().decode([Game].self, from: data)
                completion(games)
            } catch {
                print("Decoding error: \(error)")
                completion([])
            }
        }

        
        task.resume()
    }
}
