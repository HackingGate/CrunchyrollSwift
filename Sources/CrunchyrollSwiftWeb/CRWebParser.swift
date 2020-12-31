//
//  CRWebParser.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/16.
//

import Foundation
import Kanna

public struct CRWebParser {
    public enum ParserError: Error {
        case cantParseDocument
        case noDataMatched
        case jsonDecodingError(error: Error)
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
    
    static let vilosRegex = "vilos\\.config\\.media = (.*);"

    public static func vilosData(
        _ url: URL,
        completionHandler: @escaping (Result<CRWebVilos, ParserError>) -> Void
    ) {
        guard let doc = try? HTML(url: url, encoding: .utf8), let text = doc.text else {
            completionHandler(.failure(.cantParseDocument))
            return
        }
        return self.vilosData(text, completionHandler: completionHandler)
    }
    
    public static func vilosData(
        _ text: String,
        completionHandler: @escaping (Result<CRWebVilos, ParserError>) -> Void
    ) {
        guard let firstVilosConfigMediaRegexMatched = text.match(vilosRegex).first,
              firstVilosConfigMediaRegexMatched.count > 0,
              let jsonData = firstVilosConfigMediaRegexMatched[1].data(using: .utf8)
        else {
            completionHandler(.failure(.noDataMatched))
            return
        }
        do {
            let object = try JSONDecoder().decode(CRWebVilos.self, from: jsonData)
            completionHandler(.success(object))
        } catch let error {
            #if DEBUG
            print("JSON Decoding Error: \(error)")
            #endif
            completionHandler(.failure(.jsonDecodingError(error: error)))
        }
    }
}
