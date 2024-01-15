//
//  VideoPlayerViewModelTests.swift
//  VideoPlayerSwiftUITests
//
//  Created by Madusanka Prabath on 2024-01-14.
//

import XCTest
@testable import VideoPlayerSwiftUI

final class VideoPlayerViewModelTests: XCTestCase {
    
    var viewModel: VideoPlayerViewModel!
    var mockService: MockVideoService = MockVideoService()
    
    var mockVideos = MockData.mockVideos
    
    override func setUp() {
        super.setUp()
        self.mockService.videos = mockVideos
        self.viewModel = VideoPlayerViewModel(videoService: mockService)
    }
    
    func testFetchVideos() {
        viewModel.fetchVideos()
        
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(block: { _, _ in
                self.viewModel.videos.first?.title == self.mockVideos.first?.title
            }), object: nil
        )
        wait(for: [expectation], timeout: 10)
    }
    
    func testPlay() {
        viewModel.fetchVideos()
        
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(block: { _, _ in
                return self.viewModel.isPlaying == false
            }), object: nil
        )
        wait(for: [expectation], timeout: 10)
    }
    
    func testPrevVideo() {
        viewModel.fetchVideos()
        
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(block: { _, _ in
                return self.viewModel.count == 0 && self.viewModel.previousDisabled == true
            }), object: nil
        )
        wait(for: [expectation], timeout: 10)
        
        viewModel.nextVideo()
        
        XCTAssertEqual(self.viewModel.previousDisabled, false)
    }
    
    func testNextVideo() {
        
        viewModel.fetchVideos()
        
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(block: { _, _ in
                self.viewModel.nextVideo()
                return self.viewModel.count == 1 && self.viewModel.nextDisabled == true
            }), object: nil
        )
        wait(for: [expectation], timeout: 10)
    }
    
    
    
}
