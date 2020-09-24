//
//  CRWebParser.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/16.
//

import Foundation
import Kanna

public struct CRWebParser {
    static let baseURL = "https://www.crunchyroll.com/"
    public static func seriesId(_ nameToken: String) -> Int? {
        if let url = URL(string: baseURL + nameToken) {
            return seriesId(url)
        }
        return nil
    }
    public static func seriesId(_ url: URL) -> Int? {
        if let doc = try? HTML(url: url, encoding: .utf8) {
            // Search for nodes by CSS
            for node in doc.css("div, class") {
                if node.className == "show-actions" {
                    if let groupId = node["group_id"] {
                        return Int(groupId)
                    }
                }
            }
        }
        return nil
    }
}
