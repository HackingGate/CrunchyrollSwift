//
//  CRWebVilosMetadata.swift
//  
//
//  Created by HG on 2020/12/30.
//

import Foundation

public struct CRWebVilosMetadata: Codable, Identifiable {
    public let id: String
    public let seriesId: String?
    public let type: String?
    public let title: String?
    public let description: String?
    public let episodeNumber: String?
    public let displayEpisodeNumber: String?
    public let isMature: Bool?
    public let upNext: CRWebVilosUpNext?
    public let duration: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case seriesId = "series_id"
        case type = "type"
        case title = "title"
        case description = "description"
        case episodeNumber = "episode_number"
        case displayEpisodeNumber = "display_episode_number"
        case isMature = "is_mature"
        case upNext = "up_next"
        case duration = "duration"
    }
}

public struct CRWebVilosUpNext: Codable, Identifiable {
    public let title: String?
    public let id: String
    public let description: String?
    public let displayEpisodeNumber: String?
    public let duration: Int?
    public let episodeNumber: String?
    public let episodeTitle: String?
    public let extraTitle: String?
    public let isMature: Bool?
    public let isPremiumOnly: Bool?
    public let mediaTitle: String?
    public let releaseDate: String?
    public let seasonTitle: String?
    public let seriesId: String?
    public let seriesTitle: String?
    public let type: String?
    public let thumbnails: [CRWebVilosThumbnail]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case id = "id"
        case description = "description"
        case displayEpisodeNumber = "display_episode_number"
        case duration = "duration"
        case episodeNumber = "episode_number"
        case episodeTitle = "episode_title"
        case extraTitle = "extra_title"
        case isMature = "is_mature"
        case isPremiumOnly = "is_premium_only"
        case mediaTitle = "media_title"
        case releaseDate = "release_date"
        case seasonTitle = "season_title"
        case seriesId = "series_id"
        case seriesTitle = "series_title"
        case type = "type"
        case thumbnails = "thumbnails"
    }
}
