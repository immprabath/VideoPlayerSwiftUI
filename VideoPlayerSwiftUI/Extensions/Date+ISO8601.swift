//
//  Date.swift
//  VideoPlayerSwiftUI
//
//  Created by Madusanka Prabath on 2024-01-14.
//

import Foundation

extension Formatter {
    static let iso8601 = ISO8601DateFormatter()
}

extension Date {
    init(fromISO8601 iso8601: String) {
        self = Formatter.iso8601.date(from: iso8601)!
    }
}
