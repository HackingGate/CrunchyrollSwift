//
//  CRAPIImage.swift
//  
//
//  Created by HG on 2020/12/14.
//

import Foundation

public struct CRAPIImage: Codable {
    public let thumb_url: String
    public let small_url: String
    public let medium_url: String
    public let large_url: String
    public let full_url: String
    public let wide_url: String
    public let widestar_url: String
    public let fwide_url: String
    public let fwidestar_url: String
    public let width: String
    public let height: String
}
