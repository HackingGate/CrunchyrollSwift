import Foundation
import ArgumentParser
import CrunchyrollSwift
import CrunchyrollSwiftWeb

struct CRDownload: ParsableCommand {
    @Option(name: .shortAndLong, help: "Use the USA library of Crunchyroll.")
    var unblocked: Bool = true
    
    @Argument(help: "The URLs to download.")
    var urls: [String]

    mutating func run() throws {
        guard let sessionId = getSession() else { return }
        
        for url in urls {
            if let parsed = CRURLParser.parse(text: url) {
                print("\(url) parsed as \(parsed.type)")
                print(parsed.matches[4])
            } else {
                print("\(url) cannot be parsed")
            }
        }
        
        semaphore.signal()
    }
}

extension CRDownload {
    func getSession() -> String? {
        var sessionId: String?
        CRAPIService.shared.GET(
            endpoint: unblocked ? .startUSSession : .startSession,
            params: nil)
        {
            (result: Result<CRAPIResponse<CRAPIStartSession>, CRAPIService.APIError>) in
            switch result {
            case let .success(response):
                if let data = response.data {
                    print("Got \(data.countryCode ?? "") session_id \(data.id)")
                    sessionId = data.id
                } else {
                    print("No session data")
                }
            case let .failure(error):
                print("Get session failed with error: \(error)")
                break
            }
            semaphore.signal()
        }
        // https://stackoverflow.com/a/59684676/4063462
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return sessionId
    }
}
