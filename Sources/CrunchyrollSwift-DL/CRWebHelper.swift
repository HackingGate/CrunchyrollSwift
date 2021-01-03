//
//  CRWebHelper.swift
//  
//
//  Created by HG on 2020/12/30.
//

import Foundation
import CrunchyrollSwiftWeb

struct CRWebHelper {
    static func getSeriesId(
        _ url: URL,
        _ useCloudscraper: Bool = false
    ) -> Int? {
        if useCloudscraper, let text = Cloudscraper.get(url.absoluteString) {
            return CRWebParser.seriesId(text)
        } else {
            return CRWebParser.seriesId(url)
        }
    }
    
    static func getVilosData(
        _ url: URL,
        _ useCloudscraper: Bool = false
    ) -> CRWebVilos? {
        if useCloudscraper, let text = Cloudscraper.get(url.absoluteString) {
            // Set cookie is not ye supported when using cloudscraper
            return self.getVilosData(text: text)
        } else {
            return self.getVilosData(url: url)
        }
    }
    
    static func getVilosData(
        url: URL
    ) -> CRWebVilos? {
        var crWebVilos: CRWebVilos?
        CRWebParser.vilosData(url)
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
    
    static func getVilosData(
        text: String
    ) -> CRWebVilos? {
        var crWebVilos: CRWebVilos?
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
