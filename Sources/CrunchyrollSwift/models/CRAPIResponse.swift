//
//  CRAPIResponse.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/02.
//

import Foundation

public struct CRAPIResponse<T: Codable>: Codable {
    public let data: T?
    public let error: Bool
    public let code: String
    public let message: String?
    public let debug: CRAPIDebug?
}

public struct CRAPIDebug: Codable {
    public let toData: Double

    public enum CodingKeys: String, CodingKey {
        case toData = "to_data"
    }
}
