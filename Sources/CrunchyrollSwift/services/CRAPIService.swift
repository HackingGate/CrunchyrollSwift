import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct CRAPIService {
    public static let shared = CRAPIService()
    let decoder = JSONDecoder()
    public enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }
    public func GET<T: Codable>(endpoint: Endpoint,
                         params: [String: String]?,
                         completionHandler: @escaping (Result<T, APIError>) -> Void) {
        let request = buildRequest(endpoint, params: params)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(.networkError(error: error)))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noResponse))
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

    private func buildRequest(_ endpoint: Endpoint, params: [String: String]?) -> URLRequest {
        let queryURL = endpoint == .startUSSession
            ? Constants.crUnblockerURL.appendingPathComponent(endpoint.path())
            : Constants.BaseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        if endpoint == .startUSSession {

        } else {
            components.queryItems = [
                URLQueryItem(name: "locale", value: "enUS"),
                URLQueryItem(name: "version", value: "2.6.0")
            ]
            if endpoint == .startSession {
                components.queryItems! += [
                    URLQueryItem(name: "access_token", value: "WveH9VkPLrXvuNm"),
                    URLQueryItem(name: "device_type", value: "com.crunchyroll.crunchyroid"),
                    URLQueryItem(name: "device_id", value: UUID().uuidString)
                ]
            } else {
                components.queryItems! += [
                    URLQueryItem(name: "limit", value: "1000"),
                    URLQueryItem(name: "offset", value: "0")
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
        return request
    }
}
