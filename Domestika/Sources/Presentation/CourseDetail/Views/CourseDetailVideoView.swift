//
//  CourseDetailVideoView.swift
//  Domestika
//
//  Created by Xavier on 23/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit
import AVKit

protocol CourseDetailVideoViewData {
    var imageUrl: URL? { get }
    var videoUrl: URL? { get }
}

extension CourseDetailViewData: CourseDetailVideoViewData {}

class CourseDetailVideoView: DOView {

    private lazy var courseImageView: UIImageView = {
        let courseImageView = UIImageView()
        courseImageView.contentMode = .scaleAspectFill
        return courseImageView
    }()

    private lazy var playImageView: UIImageView = {
        let playImageView = UIImageView()
        playImageView.image = UIImage(systemName: "play.circle.fill")
        playImageView.tintColor = .white
        return playImageView
    }()

    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?

    override func addSubviews() {
        addSubview(courseImageView)
        courseImageView.addSubview(playImageView)
    }

    override func addConstraints() {
        courseImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        playImageView.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.center.equalToSuperview()
        }
    }

    func show(_ data: CourseDetailVideoViewData) {
        if let url = data.imageUrl {
            courseImageView.load(url: url)
        }
    }

    func play(_ url: URL) {
        let asset = AVAsset(url: url)

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
