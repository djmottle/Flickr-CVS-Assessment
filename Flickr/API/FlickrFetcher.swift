//
//  FlickrFetcher.swift
//  Flickr
//
//  Created by David Mottle on 1/28/25.
//

import SwiftUI

class FlickrFetcher: ObservableObject {
    @Published var imageData = ImageListModel()
    
    enum FetchError: Error {
        case badRequest
        case badDecoding
    }
    
    // MARK: Function that calls the url to get the ImageListModel
    /// - Parameter tags: A string gotten from the user that is used to search tags with the base url.
    /// - Throws: An error if the data retrieval or decoding fails.
    func fetchData(tags: String) async
    throws {
        guard let url = URL(string: Common.URLs.flickurl + tags) else {return}
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }
        Task { @MainActor in
            do {
                imageData = try JSONDecoder().decode(ImageListModel.self, from: data)
            } catch {
                throw FetchError.badDecoding
            }
        }
    }
}

