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
    
    /// Fetches videos from the specified endpoint.
    ///
    /// This function asynchronously fetches videos using the injected `videoService` and updates
    /// the `videos` array and `errorMessage` accordingly.
    ///
    /// - Important: This function assumes that `VideoService` has a method named `fetchVideos`.
    ///
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
    
    /// Toggles the play/pause state of the video.
    ///
    /// This function updates the 'isPlaying' property by toggling its current value.
    ///
    func togglePlayPause() {
        isPlaying.toggle()
    }
    
    /// Plays the next video in the 'videos' array.
    ///
    /// If the current video is playing, it first toggles the play/pause state.
    /// Then, it increments the 'count' to move to the next video if available.
    ///
    func nextVideo() {
        if isPlaying {
            togglePlayPause()
        }
        
        if count != videos.count - 1 {
            count += 1
        }
    }
    
    
    /// Plays the previous video in the 'videos' array.
    ///
    /// If the current video is playing, it first toggles the play/pause state.
    /// Then, it decrements the 'count' to move to the previous video if available.
    ///
    func previousVideo() {
        if isPlaying {
            togglePlayPause()
        }
        count -= 1
    }
}
