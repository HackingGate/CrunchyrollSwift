//
//  CRWebParser.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/16.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Kanna

public struct CRWebParser {
    static let baseURL = URL(string: "https://www.crunchyroll.com/")!
    static let baseTLD = ".crunchyroll.com"
    
    public enum ParserError: Error {
        case cantParseDocument
        case noDataMatched
        case jsonDecodingError(error: Error)
    }
    
    public static func seriesId(_ url: URL) -> Int? {
        if let doc = try? HTML(url: url, encoding: .utf8),
           let html = doc.toHTML {
            return seriesId(html)
        }
        return nil
    }
    
    public static func seriesId(_ text: String) -> Int? {
        if let doc = try? HTML(html: text, encoding: .utf8) {
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
    
    // TODO: not yet completed
    public static func getMediaConfig(
        mediaId: String,
        mediaURL: URL
    ) {
        let queryURL = baseURL.appendingPathComponent("xml")
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "req", value: "RpcApiVideoPlayer_GetStandardConfig"),
            URLQueryItem(name: "media_id", value: mediaId),
            URLQueryItem(name: "video_format", value: "108"),
            URLQueryItem(name: "video_quality", value: "80"),
            URLQueryItem(name: "current_page", value: mediaURL.absoluteString),
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            let xml = String(decoding: data, as: UTF8.self)
            print(xml)
//            let xmlParser = XMLParser(data: data)
//            xmlParser.parse()
        }
        task.resume()
    }
    
    public static func setSessionCookie(_ value: String) -> Bool {
        let cookieProps: [HTTPCookiePropertyKey : String] = [
            HTTPCookiePropertyKey.domain: baseTLD,
            HTTPCookiePropertyKey.path: "/",
            HTTPCookiePropertyKey.name: "session_id",
            HTTPCookiePropertyKey.value: value,
            HTTPCookiePropertyKey.secure: "FALSE",
            HTTPCookiePropertyKey.expires: "session",
        ]
        if let cookie = HTTPCookie(properties: cookieProps) {
            URLSession.shared.configuration.httpCookieStorage?.setCookie(cookie)
            return true
        } else {
            print("\(cookieProps) is invalid")
            return false
        }
    }
}
