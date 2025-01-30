//
//  Common.swift
//  Flickr
//
//  Created by David Mottle on 1/29/25.
//

import SwiftUI

struct Common {
    enum URLs {
        static let flickurl = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="
    }
    
    enum constants {
        static let searchName = "Search..."
        static let mKey = "m"
        static let unknownDimensions = "Unknown Dimensions"
        static let dateUnavailable = "Date Unavailable"
        static let noAuthor = "No Author"
        static let noDescription = "No Description"
        static let widthRegex = #"width\s*=\s*['"](\d+)['"]"#
        static let heightRegex = #"height\s*=\s*['"](\d+)['"]"#
    }
}
