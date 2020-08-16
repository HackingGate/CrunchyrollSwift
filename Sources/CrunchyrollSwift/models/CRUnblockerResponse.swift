//
//  CRUnblockerResponse.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/06.
//

import Foundation

public struct CRUnblockerResponse<T: Codable>: Codable {
    public let data: T
    public let error: Bool
    public let code: String
}
