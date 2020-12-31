//
//  Cloudscraper.swift
//  
//
//  Created by HG on 2020/12/31.
//

import PythonKit
let cloudscraper = Python.import("cloudscraper")

struct Cloudscraper {
    static func get(_ url: String) -> String? {
        // https://github.com/VeNoMouS/cloudscraper#usage
        let scraper = cloudscraper.create_scraper()
        if let text = scraper.get(url).text as CustomStringConvertible? {
            return text.description
        }
        return nil
    }
}
