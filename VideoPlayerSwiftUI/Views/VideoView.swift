//
//  File.swift
//  VideoPlayerSwiftUI
//
//  Created by Madusanka Prabath on 2024-01-14.
//

import AVKit
import SwiftUI

struct VideoPlayerView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: VideoPlayerViewModel
    
    private let videoURL: URL
    private var player: AVPlayer?
    
    init(videoURL: URL, viewModel: VideoPlayerViewModel) {
        self.videoURL = videoURL
        self.viewModel = viewModel
        self.player = AVPlayer(url: videoURL)
    }
    
    
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.showsPlaybackControls = false
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        guard let player = player else { return }
        
        uiViewController.player = player
        uiViewController.videoGravity = .resizeAspectFill
        if viewModel.isPlaying {
            player.play()
        } else {
            player.pause()
        }
    }
}


struct VideoView: View {
    
    @ObservedObject var viewModel: VideoPlayerViewModel
    
    
    var body: some View {
        VStack(spacing:0) {
            HStack{
                Spacer()
                Text("Video Player")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
            .background(Color.black)
            
            ZStack {
                VideoPlayerView(videoURL: URL(string: viewModel.videos[viewModel.count].hlsURL)!,
                                viewModel: viewModel)
                    .frame(height: 300)
                    .background(Color.red)
                VideoControlView(
                    previousDisabled: viewModel.previousDisabled,
                    nextDisabled: viewModel.nextDisabled,
                    isPlaying: viewModel.isPlaying,
                    previousAction: {
                        viewModel.previousVideo()
                    },
                    playAction: {
                        viewModel.togglePlayPause()
                    },
                    nextAction: {
                        viewModel.nextVideo()
                    })
            }
            
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text("My Cool Video Title")
                            .font(.callout)
                        Text(viewModel.videos[viewModel.count].title)
                            .font(.callout)
                    }
                    Spacer()
                }
                .padding()
                
                Text(viewModel.videos[viewModel.count].description)
                    .padding()
                    .foregroundColor(.black)
            }
            .background(Color.white)
        }
        .onDisappear {
            
        }
        
    }
}
