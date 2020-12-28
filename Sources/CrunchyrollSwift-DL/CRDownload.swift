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
                    print("Getting seiresId from web page")
                    if let seriesId = CRWebParser.seriesId(url) {
                        if let collections = getCollections(sessionId, seriesId) {
                            print("\nChoose a colletion:")
                            for (index, collection) in collections.enumerated() {
                                print("\(index + 1): \(collection.name)")
                            }
                            let collectionChoise = UserInteract.chooseNumber(from: 1...collections.count)
                            let selectedCollection = collections[collectionChoise-1]
                            print("Getting episodes from \(collectionChoise): \(selectedCollection.name)")
                            guard let selectedCollectionId = Int(selectedCollection.id) else {
                                print("Collection id is invaildate")
                                continue
                            }
                            if let episodes = getMedias(sessionId, selectedCollectionId) {
                                print("\nChoose a episode:")
                                for (index, episode) in episodes.enumerated() {
                                    print("\(index + 1): \(episode.name ?? "Untitled")")
                                }
                                let episodeChoise = UserInteract.chooseNumber(from: 1...episodes.count)
                                let selectedEpisode = episodes[episodeChoise-1]
                                print("Getting info from \(episodeChoise): \(selectedEpisode)")
                                guard let selectedEpisodeId = Int(selectedEpisode.id) else {
                                    print("Episode id is invaildate")
                                    continue
                                }
                                print(selectedEpisode)
                            }
                        }
                    } else {
                        print("Unable to get seiresId from web page")
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
