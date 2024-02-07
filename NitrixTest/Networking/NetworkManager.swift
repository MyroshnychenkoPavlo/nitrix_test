//
//  NetworkManager.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 05.02.2024.
//

import Foundation

// MARK: - NetworkManager
class NetworkManager {
    
    // MARK: - Public methods
    func fetchData(completionHandler: @escaping (Result<MovieList, Error>) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.NetworkManager.bearerToken)"
        ]
        
        if var components = URLComponents(string: "\(Constants.NetworkManager.baseURL)/discover/movie") {
            components.queryItems = [
                URLQueryItem(name: "include_adult",
                             value: "false"),
                URLQueryItem(name: "include_video",
                             value: "false"),
                URLQueryItem(name: "language",
                             value: "en-US"),
                URLQueryItem(name: "page",
                             value: "1"),
                URLQueryItem(name: "sort_by",
                             value: "popularity.desc")
            ]
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }
                guard let data else {
                    print("Error: No data")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(
                        MovieList.self,
                        from: data
                    )
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func fetchGenre(completionHandler: @escaping (Result<GenreList, Error>) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.NetworkManager.bearerToken)"
        ]
        
        if var components = URLComponents(string: "\(Constants.NetworkManager.baseURL)/genre/movie/list") {
            components.queryItems = [
                
                URLQueryItem(name: "language",
                             value: "en")
            ]
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }
                guard let data else {
                    print("Error: No data")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(
                        GenreList.self,
                        from: data
                    )
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            }
            task.resume()
        }
    }
}


