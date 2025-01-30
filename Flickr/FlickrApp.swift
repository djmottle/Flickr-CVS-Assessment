//
//  FlickrApp.swift
//  Flickr
//
//  Created by David Mottle on 1/28/25.
//

import SwiftUI

@main
struct FlickrApp: App {
    @StateObject private var fetcher = FlickrFetcher()

    var body: some Scene {
        WindowGroup {
            FlickrView()
                .environmentObject(fetcher)
        }
    }
}
