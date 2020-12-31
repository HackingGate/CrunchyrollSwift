//
//  CRCommandFlow.swift
//  
//
//  Created by HG on 2020/12/28.
//

import Foundation
import CrunchyrollSwift
import CrunchyrollSwiftWeb

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
    
    static func getStreamWithSoftSubs(_ url: URL) -> (CRWebVilosStream?, [CRWebVilosSubtitle]?) {
        if let vilosData = CRWebHelper.getVilosData(url: url),
           let streams = vilosData.streams {
            let filtered = streams.filter { (stream) -> Bool in
                stream.hardsubLang == nil && stream.format == "adaptive_hls"
            }
            return (filtered.first, vilosData.subtitles)
        } else {
            return (nil, nil)
        }
    }
    
    static func getStreamURL(_ sessionId: String, _ info: CRAPIMedia) -> URL? {
        if let streamData = info.streamData,
           let adaptive = streamData.streams.last(where: { $0.quality == "adaptive" }) ?? streamData.streams.last,
           let url = URL(string: adaptive.url) {
            return url
        }
        return nil
    }
    
    static func downloadStream(_ url: URL, name: String) {
        let youtubeDL = shell("which", "youtube-dl")
        if youtubeDL == 0 {
            _ = shell("youtube-dl", "-o", "\(name.count > 0 ? name : UUID().uuidString).%(ext)s", url.absoluteString)
        } else {
            print("youtube-dl not found")
        }
    }
    
    static func downloadSubtitle(_ subtitle: CRWebVilosSubtitle, name: String) {
        let wget = shell("which", "wget")
        if wget == 0 {
            _ = shell("wget", "-O", "\(name).\(subtitle.language).\(subtitle.format)", subtitle.url)
        } else {
            print("wget not found")
        }
    }
    
    static func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
}
