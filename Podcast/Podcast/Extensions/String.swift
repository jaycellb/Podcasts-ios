//
//  String.swift
//  Podcast
//
//  Created by Jaycell on 09/09/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
