//
//  CRAPIInfo.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/15.
//

import Foundation

public struct CRAPIInfo: Codable, Identifiable {
    public let id: String // media_id
    public let collectionId: String?
    public let episodeNumber: String?
    public let name: String?
    public let description: String?
    public let url: String?
    public let seriesName: String?
    public let collectionName: String?
    public let premiumOnly: Bool?
    public let playhead: Int?
    public let streamData: CRAPIStreamData?
    
    enum CodingKeys: String, CodingKey {
        case id = "media_id"
        case collectionId = "collection_id"
        case episodeNumber = "episode_number"
        case name = "name"
        case description = "description"
        case url = "url"
        case seriesName = "series_name"
        case collectionName = "collection_name"
        case premiumOnly = "premium_only"
        case playhead = "playhead"
        case streamData = "stream_data"
    }
}
