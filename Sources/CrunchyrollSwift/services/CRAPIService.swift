//
//  CRAPIService.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/11.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct CRAPIService {
    let baseURL = URL(string: "https://api.crunchyroll.com/")!
    let crUnblockerURL = URL(string: "https://cr-unblocker.us.to")!
    public static let shared = CRAPIService()
    let decoder = JSONDecoder()
    public enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }
    public enum Endpoint {
        case startSession, startUSSession, autocomplete, listCollections, listMedia, info
        func path() -> String {
            switch self {
            case .startSession:
                return "start_session.0.json"
            case .startUSSession:
                return "start_session"
            case .autocomplete:
                return "autocomplete.0.json"
            case .listCollections:
                return "list_collections.0.json"
            case .listMedia:
                return "list_media.0.json"
            case .info:
                return "info.0.json"
            }
        }
    }
    public func GET<T: Codable>(endpoint: Endpoint,
                         params: [String: String]?,
                         completionHandler: @escaping (Result<T, APIError>) -> Void) {
        let queryURL = endpoint == .startUSSession
            ? crUnblockerURL.appendingPathComponent(endpoint.path())
            : baseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        if endpoint == .startUSSession {
            
        } else {
            components.queryItems = [
                URLQueryItem(name: "locale", value: "enUS"),
                URLQueryItem(name: "version", value: "2.6.0"),
            ]
            if endpoint == .startSession {
                components.queryItems! += [
                    URLQueryItem(name: "access_token", value: "WveH9VkPLrXvuNm"),
                    URLQueryItem(name: "device_type", value: "com.crunchyroll.crunchyroid"),
                    URLQueryItem(name: "device_id", value: UUID().uuidString),
                ]
            } else {
                components.queryItems! += [
                    URLQueryItem(name: "limit", value: "1000"),
                    URLQueryItem(name: "offset", value: "0"),
                ]
            }
        }
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completionHandler(.failure(.noResponse))
                return
            }
            guard error == nil else {
                completionHandler(.failure(.networkError(error: error!)))
                return
            }
            do {
                let object = try self.decoder.decode(T.self, from: data)
                completionHandler(.success(object))
            } catch let error {
                #if DEBUG
                print("JSON Decoding Error: \(error)")
                #endif
                completionHandler(.failure(.jsonDecodingError(error: error)))
            }
        }
        task.resume()
    }
}
