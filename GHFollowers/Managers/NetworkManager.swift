//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Luiz Felipe on 12/11/25.
//

import Foundation

class NetworkManager {
    static  let shared = NetworkManager()
    
    let baseUrl = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "This username created is invalid")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "Unableto complete your request. Please your internet connection")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the serve. Please try again")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data receive from server was invalid, Please try again")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers: [Follower] = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "The data receive from server was invalid, Please try again")
            }
        }
        
        task.resume()
    }
}
