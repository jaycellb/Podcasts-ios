//
//  CMTime.swift
//  Podcast
//
//  Created by Jaycell on 10/11/2019.
//  Copyright © 2019 Jaycell. All rights reserved.
//

import AVKit

extension CMTime {
    func toDisplayString() -> String {
        let totalSeconds = Int(CMTimeGetSeconds(self ))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
}
