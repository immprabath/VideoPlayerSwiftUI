//
//  VideoControlView.swift
//  VideoPlayerSwiftUI
//
//  Created by Madusanka Prabath on 2024-01-14.
//

import SwiftUI

struct VideoControlView: View {
    
    var previousDisabled: Bool
    var nextDisabled: Bool
    var isPlaying: Bool
    
    var previousAction:(() -> Void)
    var playAction:(() -> Void)
    var nextAction:(() ->Void)
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    previousAction()
                }, label: {
                    Image("previous")
                })
                .frame(width: 52, height: 52)
                .background(previousDisabled ? Circle().fill(Color.gray) : Circle().fill(Color.white))
                .cornerRadius(52 / 2)
                .overlay(RoundedRectangle(cornerRadius: 52 / 2).stroke(Color.black, lineWidth: 0.5))
                .disabled(previousDisabled)
                
                Spacer()
                
                Button(action: {
                    playAction()
                }, label: {
                    Image(isPlaying ? "pause" : "play")
                })
                .frame(width: 72, height: 72)
                .background(Circle().fill(Color.white))
                .cornerRadius(72 / 2)
                .overlay(RoundedRectangle(cornerRadius: 72 / 2).stroke(Color.black, lineWidth: 0.5))
                
                Spacer()
                
                Button(action: {
                    nextAction()
                }, label: {
                    Image("next")
                })
                .frame(width: 52, height: 52)
                .background(nextDisabled ? Circle().fill(Color.gray) : Circle().fill(Color.white))
                .cornerRadius(52 / 2)
                .overlay(RoundedRectangle(cornerRadius: 52 / 2).stroke(Color.black, lineWidth: 0.5))
                .disabled(nextDisabled)
                
                Spacer()
            }
            
        }
    }
}
