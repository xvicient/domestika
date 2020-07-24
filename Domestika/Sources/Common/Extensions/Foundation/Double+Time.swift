//
//  Double+Time.swift
//  Domestika
//
//  Created by Xavier on 24/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

extension Double {
    var time: String {
        let totalSeconds = Int(self)
        let hours: Int = Int(totalSeconds / 3600)
        let minutes: Int = Int(totalSeconds % 3600 / 60)
        let seconds: Int = Int((totalSeconds % 3600) % 60)

        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
}
