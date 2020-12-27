import Foundation
import ArgumentParser
import CrunchyrollSwift

struct CRDownload: ParsableCommand {
    @Option(name: .shortAndLong, help: "Use the USA library of Crunchyroll.")
    var unblocked: Bool = false
    
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
        CRUnblockerService.shared.GET(
            endpoint: .startSession,
            params: nil)
        {
            (result: Result<CRUnblockerResponse<CRUnblockerStartSession>, CRUnblockerService.APIError>) in
            switch result {
            case let .success(response):
                print(response)
            case .failure(_):
                print("fail")
                break
            }
            semaphore.signal()
        }
    }
}
