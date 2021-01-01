import Foundation
import ArgumentParser
import CrunchyrollSwift
import CrunchyrollSwiftWeb

struct CRDownload: ParsableCommand {
    @Option(name: .shortAndLong, help: "Use the USA library of Crunchyroll.")
    var unblocked: Bool = false
    
//    @Option(help: "Foece soft subtitle. (If soft subtitle not avaliable. Will not downlaod)")
//    var softSub: Bool = true
    
    @Argument(help: "The URLs to download.")
    var urls: [String]

    mutating func run() throws {
        guard let sessionId = CRAPIHelper.getSession(unblocked) else { return }
        let success = CRWebParser.setSessionCookie(sessionId)
        if !success {
            print("Set session cookie failed.")
        }
        
        for url in urls {
            if let inputURLParsed = CRURLParser.parse(text: url) {
                print("\(url) parsed as \(inputURLParsed.type)")
                if inputURLParsed.type == .series {
                    print("Getting seiresId from web page")
                    if let seriesId = CRWebParser.seriesId(inputURLParsed.url) {
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
                                guard let selectedURL = selectedEpisode.url else {
                                    print("Episode url not found")
                                    continue
                                }
                                guard let selectedURLParsed = CRURLParser.parse(text: selectedURL),
                                      selectedURLParsed.type == .episode else {
                                    print("Episode url cannot parse")
                                    continue
                                }
                                let (stream, subtitles) = CRCommandFlow.getStreamWithSoftSubs(inputURLParsed.url)
                                if let stream = stream,
                                   let subtitles = subtitles,
                                   let streamURL = URL(string: stream.url) {
                                    print("m3u8 is \(stream.url)")
                                    CRCommandFlow.downloadStream(streamURL, name: selectedURLParsed.name)
                                    for subtitle in subtitles {
                                        CRCommandFlow.downloadSubtitle(subtitle, name: selectedURLParsed.name)
                                    }
//                                } else if softSub {
//                                    CRWebParser.getMediaConfig(mediaId: selectedEpisode.id, mediaURL: selectedURLParsed.url)
                                } else {
                                    print("Vilos data not found. Downloading hard sub video.")
                                    if let info = CRAPIHelper.getInfo(sessionId, selectedMediaId) {
                                        if let streamURL = CRCommandFlow.getStreamURL(sessionId, info) {
                                            print("m3u8 is \(streamURL)")
                                            CRCommandFlow.downloadStream(streamURL, name: selectedURLParsed.name)
                                        } else {
                                            print("Unable to get m3u8 from media_id \(selectedMediaId)")
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        print("Unable to get seiresId from web page")
                    }
                } else if inputURLParsed.type == .episode {
                    let (stream, subtitles) = CRCommandFlow.getStreamWithSoftSubs(inputURLParsed.url)
                    if let stream = stream,
                       let subtitles = subtitles,
                       let streamURL = URL(string: stream.url) {
                        print("m3u8 is \(stream.url)")
                        CRCommandFlow.downloadStream(streamURL, name: inputURLParsed.name)
                        for subtitle in subtitles {
                            CRCommandFlow.downloadSubtitle(subtitle, name: inputURLParsed.name)
                        }
//                    } else if softSub {
//                        CRWebParser.getMediaConfig(mediaId: inputURLParsed.matches[4], mediaURL: inputURLParsed.url)
//                        _ = semaphore.wait(wallTimeout: .distantFuture)
                    } else {
                        print("Vilos stream and subtitles not found. Downloading hard sub stream instead.")
                        if let mediaId = Int(inputURLParsed.matches[4]) {
                            if let info = CRAPIHelper.getInfo(sessionId, mediaId) {
                                if let stream = CRCommandFlow.getStreamURL(sessionId, info) {
                                    print("m3u8 is \(stream)")
                                    CRCommandFlow.downloadStream(stream, name: inputURLParsed.name)
                                } else {
                                    print("Unable to get m3u8 from media_id \(mediaId)")
                                }
                            }
                        } else {
                            print("Cannot read media_id")
                        }
                    }
                }
            } else {
                print("\(url) cannot be parsed")
            }
        }
        
        semaphore.signal()
    }
}
