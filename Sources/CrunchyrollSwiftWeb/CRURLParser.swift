//
//  CRURLParser.swift
//  
//
//  Created by HG on 2020/12/28.
//

import Foundation

public struct CRURLParser {
    // adapted from https://github.com/simplymemes/crunchyroll-dl/blob/master/index.js
    static let seriesRegex = "https?:\\/\\/(?:(www|m)\\.)?(crunchyroll\\.com(\\/[a-z]{2}|\\/[a-z]{2}-[a-z]{2})?\\/([\\w\\-]+))\\/?(?:\\?|$)"
    static let episodeRegex = "https?:\\/\\/(?:(www|m)\\.)?(crunchyroll\\.(?:com|fr)(\\/[a-z]{2}|\\/[a-z]{2}-[a-z]{2})?\\/(?:media(?:-|\\/\\?id=)|[^/]*\\/[^/?&]*?)([0-9]+))(?:[/?&]|$)"
    
    public static func parse(text: String) -> CRURLParsed? {
        if let url = URL(string: text),
           let name = url.pathComponents.last {
            if let firstSeriesRegexMatched = text.match(seriesRegex).first {
                if firstSeriesRegexMatched.count > 0 {
                    return CRURLParsed(url: url, type: .series, matches: firstSeriesRegexMatched, name: name)
                }
            }
            if let firstEpisodeRegexMatched = text.match(episodeRegex).first {
                if firstEpisodeRegexMatched.count > 0 {
                    return CRURLParsed(url: url, type: .episode, matches: firstEpisodeRegexMatched, name: name)
                }
            }
        }
        return nil
    }
}

public struct CRURLParsed {
    public let url: URL
    public let type: CRURLType
    public let matches: [String]
    public let name: String
}

public enum CRURLType {
    case series, episode
}
