import Foundation

public struct CRAPISeries: Codable, Identifiable {
    public let `class`: String
    public let id: String // series_id
    public let etpGuid: String
    public let url: String
    public let name: String
    public let mediaType: String
    public let landscapeImage: CRAPIImage
    public let portraitImage: CRAPIImage
    public let description: String

    enum CodingKeys: String, CodingKey {
        case `class` = "class"
        case id = "series_id"
        case etpGuid = "etp_guid"
        case url = "url"
        case name = "name"
        case mediaType = "media_type"
        case landscapeImage = "landscape_image"
        case portraitImage = "portrait_image"
        case description = "description"
    }
}
