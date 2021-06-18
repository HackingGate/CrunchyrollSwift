//
//  RegexExtension.swift
//  
//
//  Created by HG on 2020/12/30.
//

import Foundation

// https://stackoverflow.com/a/56616990/4063462
extension String {
    func match(_ regex: String) -> [[String]] {
        let nsString = self as NSString
        return (try? NSRegularExpression(pattern: regex, options: []))?.matches(in: self, options: [], range: NSRange(location: 0, length: count)).map { match in
            (0..<match.numberOfRanges).map { match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0)) }
        } ?? []
    }
}
