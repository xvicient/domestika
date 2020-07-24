//
//  CoursDetailVideoView.swift
//  Domestika
//
//  Created by Xavier on 23/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import AVKit
import UIKit

class CourseDetailVideoView: DOView {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    override func setup() {
        backgroundColor = .blue
    }

    func play(asset: AVAsset) {
        if let player = player, let playerLayer = playerLayer {
            player.pause()
            playerLayer.removeFromSuperlayer()
        }
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = bounds
        playerLayer.name = "AVPlayerLayer"
        layer.addSublayer(playerLayer)
        player.play()

        self.player = player
        self.playerLayer = playerLayer
    }

    func pause() {
        player?.pause()
        layer.sublayers?.filter { $0.name == "AVPlayerLayer" }.forEach { $0.removeFromSuperlayer() }
    }
}
