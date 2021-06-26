import Foundation

public struct CRAPIStreamData: Codable {
    public let hardsubLang: String?
    public let audioLang: String?
    public let format: String?
    public let streams: [CRAPIStream]

    enum CodingKeys: String, CodingKey {
        case hardsubLang = "hardsub_lang"
        case audioLang = "audio_lang"
        case format = "format"
        case streams = "streams"
    }
}
