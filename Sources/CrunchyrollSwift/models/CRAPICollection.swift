import Foundation

public struct CRAPICollection: Codable, Identifiable {
    public let id: String // collection_id
    public let seriesId: String
    public let name: String
    public let description: String
    public let created: String

    enum CodingKeys: String, CodingKey {
        case id = "collection_id"
        case seriesId = "series_id"
        case name = "name"
        case description = "description"
        case created = "created"
    }
}
