//
//  Extensions.swift
//  Flickr
//
//  Created by David Mottle on 1/29/25.
//

import SwiftUI

// MARK: Extension of string used to get the dimensions that are in the description
/// - Parameter regex: The regex string we need to use to find the dimensions.
/// - Returns: An string with the given dimension.
extension String {
    func matchingFirstGroup(using regex: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: regex) else { return nil }
        let range = NSRange(startIndex..<endIndex, in: self)
        let match = regex.firstMatch(in: self, options: [], range: range)
        if let range = match?.range(at: 1), let swiftRange = Range(range, in: self) {
            return String(self[swiftRange])
        }
        return nil
    }
}
