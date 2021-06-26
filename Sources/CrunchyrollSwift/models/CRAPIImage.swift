import Foundation

public struct CRAPIImage: Codable {
    public let thumbUrl: String
    public let smallUrl: String
    public let mediumUrl: String
    public let largeUrl: String
    public let fullUrl: String
    public let wideUrl: String
    public let widestarUrl: String
    public let fwideUrl: String
    public let fwidestarUrl: String
    public let width: String
    public let height: String

    public enum CodingKeys: String, CodingKey {
        case thumbUrl = "thumb_url"
        case smallUrl = "small_url"
        case mediumUrl = "medium_url"
        case largeUrl = "large_url"
        case fullUrl = "full_url"
        case wideUrl = "wide_url"
        case widestarUrl = "widestar_url"
        case fwideUrl = "fwide_url"
        case fwidestarUrl = "fwidestar_url"
        case width = "width"
        case height = "height"
    }
}
