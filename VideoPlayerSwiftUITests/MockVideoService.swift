//
//  MockVideoService.swift
//  VideoPlayerSwiftUITests
//
//  Created by Madusanka Prabath on 2024-01-14.
//

import Foundation
@testable import VideoPlayerSwiftUI


class MockVideoService: VideoService {
    var videos:[Video] = []
    
    func fetchVideos(endpoint: String, completion: @escaping (Result<[VideoPlayerSwiftUI.Video], VideoPlayerSwiftUI.NetworkError>) -> Void) {
        completion(.success(videos))
    }
}
