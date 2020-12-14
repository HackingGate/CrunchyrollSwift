//
//  CRAPIEpisode.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/02.
//

import Foundation

public struct CRAPIMedia: Codable, Identifiable {
    public let id: String // media_id
    public let collectionId: String?
    public let episodeNumber: String?
    public let name: String?
    public let description: String?
    public let screenshotImage: CRAPIMediaScreenshotImage?
    public let url: String?
    public let seriesName: String?
    public let collectionName: String?
    public let premiumOnly: Bool?
    public var streamData: CRAPIStreamData?
    public let playhead: Int?
    
    public enum CodingKeys: String, CodingKey {
        case id = "media_id"
        case collectionId = "collection_id"
        case episodeNumber = "episode_number"
        case name = "name"
        case description = "description"
        case screenshotImage = "screenshot_image"
        case url = "url"
        case seriesName = "series_name"
        case collectionName = "collection_name"
        case premiumOnly = "premium_only"
        case streamData = "stream_data"
        case playhead = "playhead"
    }
}
