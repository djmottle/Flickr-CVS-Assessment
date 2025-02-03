//
//  FlickrImageDetailView.swift
//  Flickr
//
//  Created by David Mottle on 1/29/25.
//

import SwiftUI

struct FlickrImageDetailView: View {
    var image: Image
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            AsyncImage(url: URL(string: image.media[Common.constants.mKey] ?? "")) {image in
                image
                    .transition(.opacity.animation(.easeInOut(duration: 0.5)))
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .accessibilityLabel("Image is titled \(image.title)")
            .accessibilityHint("There is an image here.")
            
            Text(image.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .dynamicTypeSize(.medium ... .xLarge)
                .accessibilityLabel("Title: \(image.title)")
            Text(image.formattedDescription)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .dynamicTypeSize(.medium ... .xLarge)
                .accessibilityLabel("Description: \(image.formattedDescription)")
            Text(image.formattedAuthor)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .dynamicTypeSize(.medium ... .xLarge)
                .accessibilityLabel("Author: \(image.formattedAuthor)")
            Text(image.formattedDate)
                .font(.subheadline)
                .dynamicTypeSize(.medium ... .xLarge)
                .accessibilityLabel("Date: \(image.formattedDate)")
            if let height = image.dimensions.height, let width = image.dimensions.width {
                Text("\(width) pixels x \(height) pixels")
                    .font(.subheadline)
                    .dynamicTypeSize(.medium ... .xLarge)
                    .accessibilityLabel("Dimensions: \(width) pixels x \(height) pixels")
            } else {
                Text(Common.constants.unknownDimensions)
                    .font(.subheadline)
                    .dynamicTypeSize(.medium ... .xLarge)
                    .accessibilityLabel(Common.constants.unknownDimensions)
            }
            
            ShareLink(item: share(from: image))
                .padding(10)
        }
    }
    // MARK: Function used to create the share data
    /// - Parameter image: An object of Image type.
    /// - Returns: An string formatted the way this would eb shared.
    private func share (from image: Image) -> String {
        let shareData = """
                    Title: \(image.title)
                    Author: \(image.formattedAuthor)
                    Published: \(image.formattedDate)
                    Description: \(image.formattedDescription)
                    Image: \(image.media[Common.constants.mKey] ?? "")
                    """
        return shareData
    }
}
