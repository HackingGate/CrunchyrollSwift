//
//  CRAPIStream.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/09.
//

import Foundation

public struct CRAPIStream: Codable {
    public let quality: String
    public let expires: String
    public let url: String
}
