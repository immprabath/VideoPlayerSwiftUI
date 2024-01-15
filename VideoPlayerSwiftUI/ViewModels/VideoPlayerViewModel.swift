//
//  VideoPlayerViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Madusanka Prabath on 2024-01-14.
//

import Foundation

class VideoPlayerViewModel: ObservableObject {
    @Published var videos:[Video] = []
    @Published var errorMessage:String?
    @Published var isPlaying: Bool = false
    
    @Published var count: Int = 0
    
    var previousDisabled: Bool { count == 0 }
    var nextDisabled: Bool { count == self.videos.count - 1 }
    
    
    private let videoService: VideoService
    
    init(videoService: VideoService) {
        self.videoService = videoService
    }
    
    func fetchVideos() {
        videoService.fetchVideos(endpoint: Constants.videosEndpoint) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let values):
                    self.videos = values
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func togglePlayPause() {
        isPlaying.toggle()
    }
    
    func nextVideo() {
        if isPlaying {
            togglePlayPause()
        }
        
        if count != videos.count - 1 {
            count += 1
        }
    }
    
    func previousVideo() {
        if isPlaying {
            togglePlayPause()
        }
        count -= 1
    }
}
