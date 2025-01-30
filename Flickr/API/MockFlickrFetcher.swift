//
//  MockFlickrFetcher.swift
//  Flickr
//
//  Created by David Mottle on 1/29/25.
//

import SwiftUI

class MockFlickrFetcher: ObservableObject {
    @Published var mockImageData = ImageListModel()
    var mockData: Data?
    var mockResponseCode: Int?
    
    enum FetchError: Error {
        case badRequest
        case badDecoding
    }
    
    func fetchData(tags: String) async throws {
        if let responseCode = mockResponseCode, responseCode != 200 {
            throw FetchError.badRequest
        }
        
        guard let mockData = mockData else {
            throw FetchError.badRequest
        }
        
        do {
            let decodedData = try JSONDecoder().decode(ImageListModel.self, from: mockData)
            await MainActor.run {
                self.mockImageData = decodedData
            }
        } catch {
            throw FetchError.badDecoding
        }
    }
}
