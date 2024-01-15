//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var videoViewModel = VideoPlayerViewModel(videoService: VideoServiceImplement())

    var body: some View {
        
        VStack() {
            if !videoViewModel.videos.isEmpty {
                VideoView(viewModel: videoViewModel)
            } else {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .onAppear() {
            videoViewModel.fetchVideos()
        }
        .navigationBarTitle("Video Player", displayMode: .inline)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
