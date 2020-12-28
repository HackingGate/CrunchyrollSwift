//
//  File.swift
//  
//
//  Created by HG on 2020/12/28.
//

import Foundation
import CrunchyrollSwift

struct CRCommandFlow {
    static func selectCollection(_ sessionId: String, _ seriesId: Int) -> CRAPICollection? {
        if let collections = CRAPIHelper.getCollections(sessionId, seriesId) {
            print("\nChoose a colletion:")
            for (index, collection) in collections.enumerated() {
                print("\(index + 1): \(collection.name)")
            }
            let collectionChoise = UserInteract.chooseNumber(from: 1...collections.count)
            let selectedCollection = collections[collectionChoise-1]
            print("Getting episodes from \(collectionChoise): \(selectedCollection.name)")
            return selectedCollection
        } else {
            return nil
        }
    }
    
    static func selectEpisode(_ sessionId: String, _ collectionId: Int) -> CRAPIMedia? {
        if let episodes = CRAPIHelper.getMedias(sessionId, collectionId) {
            print("\nChoose a episode:")
            for (index, episode) in episodes.enumerated() {
                print("\(index + 1): \(episode.name ?? "Untitled")")
            }
            let episodeChoise = UserInteract.chooseNumber(from: 1...episodes.count)
            let selectedEpisode = episodes[episodeChoise-1]
            print("Getting info from \(episodeChoise): \(selectedEpisode.name ?? "Untitled")")
            return selectedEpisode
        } else {
            return nil
        }
    }
    
    static func getStream(_ sessionId: String, _ mediaId: Int) -> URL? {
        if let info = CRAPIHelper.getInfo(sessionId, mediaId),
           let streamData = info.streamData,
           let adaptive = streamData.streams.last(where: { $0.quality == "adaptive" }) ?? streamData.streams.last,
           let url = URL(string: adaptive.url) {
            return url
        }
        return nil
    }
}
