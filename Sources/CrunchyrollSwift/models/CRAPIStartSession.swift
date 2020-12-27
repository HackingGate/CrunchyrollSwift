//
//  CRUnblockerStartSession.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/06.
//

import Foundation

public struct CRAPIStartSession: Codable, Identifiable {
    public let id: String // session_id
    public let countryCode: String?
    public let ip: String?
    public let deviceType: String?
    public let deviceId: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "session_id"
        case countryCode = "country_code"
        case ip = "ip"
        case deviceType = "device_type"
        case deviceId = "device_id"
//        case user = "user"
//        case auth = "auth"
//        case expires = "expires"
//        case version = "version"
    }
}
