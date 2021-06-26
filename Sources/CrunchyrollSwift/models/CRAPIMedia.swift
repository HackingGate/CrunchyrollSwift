import Foundation

public struct CRAPIMedia: Codable, Identifiable {
    public let `class`: String?
    public let id: String // media_id
    public let etpGuid: String?
    public let collectionId: String?
    public let collectionEtpGuid: String?
    public let seriesId: String?
    public let seriesEtpGuid: String?
    public let mediaType: String?
    public let episodeNumber: String?
    public let name: String?
    public let description: String?
    public let screenshotImage: CRAPIImage?
    public let bifUrl: String?
    public let url: String?
    public let clip: Bool?
    public let available: Bool?
    public let premiumAvailable: Bool?
    public let freeAvailable: Bool?
    public let availableTime: String?
    public let unavailableTime: String?
    public let premiumAvailableTime: String?
    public let premiumUnavailableTime: String?
    public let freeAvailableTime: String?
    public let freeUnavailableTime: String?
    public let availabilityNotes: String?
    public let created: String?
    public let seriesName: String?
    public let collectionName: String?
    public let premiumOnly: Bool?
    public var streamData: CRAPIStreamData?
    public let playhead: Int?

    public enum CodingKeys: String, CodingKey {
        case `class` = "class"
        case id = "media_id"
        case etpGuid = "etp_guid"
        case collectionId = "collection_id"
        case collectionEtpGuid = "collection_etp_guid"
        case seriesId = "series_id"
        case seriesEtpGuid = "series_etp_guid"
        case mediaType = "media_type"
        case episodeNumber = "episode_number"
        case name = "name"
        case description = "description"
        case screenshotImage = "screenshot_image"
        case bifUrl = "bif_url"
        case url = "url"
        case clip = "clip"
        case available = "available"
        case premiumAvailable = "premium_available"
        case freeAvailable = "free_available"
        case availableTime = "available_time"
        case unavailableTime = "unavailable_time"
        case premiumAvailableTime = "premium_available_time"
        case premiumUnavailableTime = "premium_unavailable_time"
        case freeAvailableTime = "free_available_time"
        case freeUnavailableTime = "free_unavailable_time"
        case availabilityNotes = "availability_notes"
        case created = "created"
        case seriesName = "series_name"
        case collectionName = "collection_name"
        case premiumOnly = "premium_only"
        case streamData = "stream_data"
        case playhead = "playhead"
    }
}
