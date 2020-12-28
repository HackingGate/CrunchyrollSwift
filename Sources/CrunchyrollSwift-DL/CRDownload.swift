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
                if parsed.type == .series, let url = URL(string: url) {
                    if let seriesId = CRWebParser.seriesId(url) {
                        if let collections = getCollections(sessionId, seriesId) {
                            print(collections)
                        }
                    } else {
                        print("Unable to get seiresId from web")
                    }
                } else if parsed.type == .episode {
                    if let mediaId = Int(parsed.matches[4]) {
                        if let info = getInfo(sessionId, mediaId),
                           let streamData = info.streamData,
                           let adaptive = streamData.streams.last(where: { $0.quality == "adaptive" }) ?? streamData.streams.last,
                           let url = URL(string: adaptive.url) {
                            print("m3u8 is \(url)")
                        }
                    } else {
                        print("Cannot read media_id")
                    }
                }
            } else {
                print("\(url) cannot be parsed")
            }
        }
        
        semaphore.signal()
    }
}
