//
//  CRNameParser.swift
//  
//
//  Created by HG on 2020/09/24.
//

import Foundation

public struct CRNameParser {
    public static func nameToken(_ title: String) -> String {
        // TODO: improve
        var nameToken = title
        nameToken = nameToken.replacingOccurrences(of: " ", with: "-")
        nameToken = nameToken.replacingOccurrences(of: "--", with: "-")
        nameToken = nameToken.replacingOccurrences(of: ":", with: "")
        nameToken = nameToken.components(separatedBy: "Season")[0]
        return nameToken.lowercased()
    }
}
