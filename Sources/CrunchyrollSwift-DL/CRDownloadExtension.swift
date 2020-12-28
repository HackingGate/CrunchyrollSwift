//
//  CRDownloadExtension.swift
//  
//
//  Created by HG on 2020/12/28.
//

import Foundation
import CrunchyrollSwift
import CrunchyrollSwiftWeb

extension CRDownload {
    func getSession() -> String? {
        var sessionId: String?
        CRAPIService.shared.GET(
            endpoint: unblocked ? .startUSSession : .startSession,
            params: nil)
        {
            (result: Result<CRAPIResponse<CRAPIStartSession>, CRAPIService.APIError>) in
            switch result {
            case let .success(response):
                if let data = response.data {
                    print("Got \(data.countryCode ?? "") session_id \(data.id)")
                    sessionId = data.id
                } else {
                    print("No session data")
                }
            case let .failure(error):
                print("Get session failed with error: \(error)")
                break
            }
            semaphore.signal()
        }
        // https://stackoverflow.com/a/59684676/4063462
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return sessionId
    }
    
    func getInfo(_ sessionId: String, _ mediaId: Int) -> CRAPIMedia? {
        let fields: [CRAPIMedia.CodingKeys] = [.id, .streamData]
        
        let params = [
            "session_id": sessionId,
            "media_id": String(mediaId),
            "fields": fields.map({ "media." + $0.stringValue }).joined(separator: ",")
        ]
        
        var crAPIMedia: CRAPIMedia?
        
        CRAPIService.shared.GET(
            endpoint: .info,
            params: params)
        {
            (result: Result<CRAPIResponse<CRAPIMedia>, CRAPIService.APIError>) in
            switch result {
            case let .success(response):
                if let data = response.data {
                    crAPIMedia = data
                } else {
                    print("No CRAPIMedia data")
                }
            case .failure(_):
                break
            }
            semaphore.signal()
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return crAPIMedia
    }
}
