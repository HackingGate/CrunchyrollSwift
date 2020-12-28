import Foundation
import ArgumentParser
import CrunchyrollSwift
import CrunchyrollSwiftWeb

struct CRDownload: ParsableCommand {
    @Option(name: .shortAndLong, help: "Use the USA library of Crunchyroll.")
    var unblocked: Bool = false
    
    @Argument(help: "The URLs to download.")
    var urls: [String]

    mutating func run() throws {
        guard let sessionId = CRAPIHelper.getSession(unblocked) else { return }
        
        for url in urls {
            if let parsed = CRURLParser.parse(text: url) {
                print("\(url) parsed as \(parsed.type)")
                if parsed.type == .series, let url = URL(string: url) {
                    print("Getting seiresId from web page")
                    if let seriesId = CRWebParser.seriesId(url) {
                        if let selectedCollection = CRCommandFlow.selectCollection(sessionId, seriesId) {
                            guard let selectedCollectionId = Int(selectedCollection.id) else {
                                print("Collection id is invaild")
                                continue
                            }
                            if let selectedEpisode = CRCommandFlow.selectEpisode(sessionId, selectedCollectionId) {
                                guard let selectedMediaId = Int(selectedEpisode.id) else {
                                    print("Episode id is invaild")
                                    continue
                                }
                                if let info = CRAPIHelper.getInfo(sessionId, selectedMediaId) {
                                    if let stream = CRCommandFlow.getStream(sessionId, info) {
                                        print("m3u8 is \(stream)")
                                        CRCommandFlow.downloadStream(stream, name: "EP\(info.episodeNumber ?? "") - \(info.name ?? "")")
                                    } else {
                                        print("Unable to get m3u8 from media_id \(selectedMediaId)")
                                    }
                                }
                            }
                        }
                    } else {
                        print("Unable to get seiresId from web page")
                    }
                } else if parsed.type == .episode {
                    if let mediaId = Int(parsed.matches[4]) {
                        if let info = CRAPIHelper.getInfo(sessionId, mediaId) {
                            if let stream = CRCommandFlow.getStream(sessionId, info) {
                                print("m3u8 is \(stream)")
                                CRCommandFlow.downloadStream(stream, name: "EP\(info.episodeNumber ?? "") - \(info.name ?? "")")
                            } else {
                                print("Unable to get m3u8 from media_id \(mediaId)")
                            }
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
