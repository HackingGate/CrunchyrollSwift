//
//  CRWebHelper.swift
//  
//
//  Created by HG on 2020/12/30.
//

import Foundation
import CrunchyrollSwiftWeb

struct CRWebHelper {
    static func getVilosData(
        url: URL
    ) -> CRWebVilos? {
        var crWebVilos: CRWebVilos?
        guard let text = Cloudscraper.get(url.absoluteString) else {
            return crWebVilos
        }
        CRWebParser.vilosData(text)
        {
            (result: Result<CRWebVilos, CRWebParser.ParserError>) in
            switch result {
            case let .success(response):
                crWebVilos = response
            case let .failure(error):
                print("Parse failed with error: \(error)")
                break
            }
            semaphore.signal()
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return crWebVilos
    }
}
