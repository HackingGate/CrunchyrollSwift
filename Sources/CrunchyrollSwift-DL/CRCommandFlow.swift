//
//  File.swift
//  
//
//  Created by HG on 2020/12/28.
//

import Foundation

struct CRCommandFlow {
    static func getStream(_ sessionId: String, _ mediaId: Int) -> URL? {
        if let info = CRAPIHelper.getInfo(sessionId, mediaId),
           let streamData = info.streamData,
           let adaptive = streamData.streams.last(where: { $0.quality == "adaptive" }) ?? streamData.streams.last,
           let url = URL(string: adaptive.url) {
            return url
        }
        return nil
    }
}
