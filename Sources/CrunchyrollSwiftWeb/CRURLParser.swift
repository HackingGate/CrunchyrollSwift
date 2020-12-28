//
//  CRURLParser.swift
//  
//
//  Created by HG on 2020/12/28.
//

import Foundation

public struct CRURLParser {
    // adapted from https://github.com/simplymemes/crunchyroll-dl/blob/master/index.js
    static let seriesRegex = "/https?:\\/\\/(?:(www|m)\\.)?(crunchyroll\\.com(\\/[a-z]{2}|\\/[a-z]{2}-[a-z]{2})?\\/([\\w\\-]+))\\/?(?:\\?|$)/"
    static let episodeRegex = "https?:\\/\\/(?:(www|m)\\.)?(crunchyroll\\.(?:com|fr)(\\/[a-z]{2}|\\/[a-z]{2}-[a-z]{2})?\\/(?:media(?:-|\\/\\?id=)|[^/]*\\/[^/?&]*?)([0-9]+))(?:[/?&]|$)"
    
    public static func parse(text: String) -> CRURLParsed? {
        if let firstSeriesRegexMatched = text.match(seriesRegex).first {
            if firstSeriesRegexMatched.count > 0 {
                return CRURLParsed(url: text, type: .series, matches: firstSeriesRegexMatched)
            }
        }
        if let firstEpisodeRegexMatched = text.match(episodeRegex).first {
            if firstEpisodeRegexMatched.count > 0 {
                return CRURLParsed(url: text, type: .episode, matches: firstEpisodeRegexMatched)
            }
        }
        return nil
    }
}

// https://stackoverflow.com/a/56616990/4063462
extension String {
    func match(_ regex: String) -> [[String]] {
        let nsString = self as NSString
        return (try? NSRegularExpression(pattern: regex, options: []))?.matches(in: self, options: [], range: NSMakeRange(0, count)).map { match in
            (0..<match.numberOfRanges).map { match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0)) }
        } ?? []
    }
}

public struct CRURLParsed {
    public let url: String
    public let type: CRURLType
    public let matches: [String]
}

public enum CRURLType {
    case series, episode
}
