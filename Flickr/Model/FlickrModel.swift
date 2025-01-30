//
//  File.swift
//  Flickr
//
//  Created by David Mottle on 1/28/25.
//

import SwiftUI

struct ImageListModel: Codable {
    var items: [Image]?
}

struct Image: Codable, Hashable {
    var title: String
    var link: String
    var media: Dictionary<String, String>
    var description: String
    var published: String
    var author: String
    var tags: String
    
    var formattedAuthor: String {
        let regex = try? NSRegularExpression(pattern: "\\(\"(.*?)\"\\)")
        if let match = regex?.firstMatch(in: author, range: NSRange(description.startIndex..., in: author)), let range = Range(match.range(at: 1), in: author) {
            return String(author[range])
        }
        return Common.constants.noAuthor
    }
    
    var formattedDescription: String {
        let regex = try? NSRegularExpression(pattern: "<p>(.*?)<\\/p>")
        if let matches = regex?.matches(in: description, range: NSRange(description.startIndex..., in: description)), matches.count >= 3, let range = Range(matches[2].range(at: 1), in: description) {
                return description[range].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return Common.constants.noDescription
    }
    
    var formattedDate: String {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: published)?.formatted(date: .abbreviated, time: .omitted) ?? Common.constants.dateUnavailable
    }
    
    var dimensions: (width: Int?, height: Int?) {
        getDimensions(from: description)
    }
    
    func getDimensions(from description: String) -> (width: Int?, height: Int?) {
        
        let width = description.matchingFirstGroup(using: Common.constants.widthRegex).flatMap { Int($0) }
        let height = description.matchingFirstGroup(using: Common.constants.heightRegex).flatMap { Int($0) }
        
        return (width, height)
    }
}
