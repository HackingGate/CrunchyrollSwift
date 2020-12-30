//
//  CRWebVilos.swift
//  
//
//  Created by HG on 2020/12/30.
//

import Foundation

public struct CRWebVilos: Codable {
    public let metadata: CRWebVilosMetadata
    public let thumbnail: CRWebVilosThumbnail?
    public let streams: [CRWebVilosStream]?
    public let adBreaks: [CRWebVilosAdBreak]?
    public let subtitles: [CRWebVilosSubtitle]?
    public let preview: CRWebVilosPreview?
    
    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case thumbnail = "thumbnail"
        case streams = "streams"
        case adBreaks = "adBreaks"
        case subtitles = "subtitles"
        case preview = "preview"
    }
}
