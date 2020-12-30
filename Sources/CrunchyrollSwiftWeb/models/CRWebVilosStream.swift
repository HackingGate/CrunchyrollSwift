//
//  CRWebVilosStream.swift
//  
//
//  Created by HG on 2020/12/30.
//

import Foundation

public struct CRWebVilosStream: Codable {
    public let format: String
    public let audioLang: String
    public let hardsubLang: String?
    public let url: String
    public let resolution: String
    
    enum CodingKeys: String, CodingKey {
        case format = "format"
        case audioLang = "audio_lang"
        case hardsubLang = "hardsub_lang"
        case url = "url"
        case resolution = "resolution"
    }
}
