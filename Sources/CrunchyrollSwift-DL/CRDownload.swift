import Foundation
import ArgumentParser
import CrunchyrollSwift

struct CRDownload: ParsableCommand {
    @Option(name: .shortAndLong, help: "Use the USA library of Crunchyroll.")
    var unblocked: Bool = true
    
    @Argument(help: "The URLs to download.")
    var urls: [String]

    mutating func run() throws {
        for url in urls {
            print("Downloading... \(url)")
        }
        getSession()
    }
}

extension CRDownload {
    func getSession() {
        CRAPIService.shared.GET(
            endpoint: unblocked ? .startUSSession : .startSession,
            params: nil)
        {
            (result: Result<CRAPIResponse<CRAPIStartSession>, CRAPIService.APIError>) in
            switch result {
            case let .success(response):
                print(response)
            case .failure(_):
                break
            }
            semaphore.signal()
        }
    }
}
