//
//  VideoService.swift
//  VideoPlayerSwiftUI
//
//  Created by Madusanka Prabath on 2024-01-14.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

protocol VideoService {
    func fetchVideos(endpoint: String, completion: @escaping(Result<[Video], NetworkError>) -> Void)
}

class VideoServiceImplement: VideoService {
    
    private let baseURL = Constants.baseURL
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchVideos(endpoint: String, completion: @escaping(Result<[Video], NetworkError>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed(error ?? NetworkError.invalidResponse)))
                return
            }
            
            do {
                let videos = try JSONDecoder().decode([Video].self, from: data)
                let sortedVideos = videos.sorted{ $0.publishedAt > $1.publishedAt }
                completion(.success(sortedVideos))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }.resume()
    }
}
