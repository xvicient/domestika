//
//  CourseDetailVideoView.swift
//  Domestika
//
//  Created by Xavier on 23/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import AVKit
import UIKit

enum VideoBufferingKey: String {
    case playbackBufferEmpty
    case playbackLikelyToKeepUp
    case playbackBufferFull
    case status
}

protocol CourseDetailVideoViewDelegate: AnyObject {
    func didTapPlayButton()
    func didTapPauseButton()
    func didTapBackwardButton()
    func didTapForwardButton()
    func didTapShowPlayerControls()
    func didTapHidePlayerControls()
    func didStartVideoBuffering()
    func didStopVideoBuffering()
    func didStartVideoPlaying()
}

struct CourseDetailVideoViewData: Equatable {
    let videoUrl: URL?
    let timeText: String
}

class CourseDetailVideoView: DOView {
    weak var videoDelegate: CourseDetailVideoViewDelegate?

    private lazy var playerOverlayView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapVideo)))
        return view
    }()

    private lazy var playerControlsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.roundCorners(radius: 12.0)
        return view
    }()

    private lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.font = UIFont.systemFont(ofSize: 10.0, weight: .medium)
        label.numberOfLines = 1
        return label
    }()

    private lazy var timeSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbSize(CGSize(width: 6.0, height: 6.0))
        slider.isUserInteractionEnabled = false
        slider.minimumTrackTintColor = .systemGray5
        slider.minimumValue = 0
        return slider
    }()

    private lazy var leftTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray5
        label.font = UIFont.systemFont(ofSize: 10.0, weight: .medium)
        label.numberOfLines = 1
        return label
    }()

    private lazy var toggleVideoButton: UIButton = {
        let button = UIButton()
        button.setImage(.playerPause, for: .normal)
        button.tintColor = .systemGray5
        button.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        button.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        return button
    }()

    private lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.setImage(.backward, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 2.0, left: -15.0, bottom: 0.0, right: 0.0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 8.0, weight: .regular)
        button.addTarget(self, action: #selector(didTapBackwardButton), for: .touchUpInside)
        return button
    }()

    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(.forward, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 2.0, left: -15.0, bottom: 0.0, right: 0.0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 8.0, weight: .regular)
        button.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
        return button
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .gray
        view.style = .large
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()

    private var player: AVPlayer? {
        willSet {
            removeVideoObservers()
        }
        didSet {
            addVideoObservers()
        }
    }

    private var playerLayer: AVPlayerLayer?
    private var timeObserverToken: Any?
    private var isVideoPlaying = false

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }

    deinit {
        removeVideoObservers()
    }

    override func setup() {
        backgroundColor = .systemGray6
    }

    override func addSubviews() {
        addSubview(playerOverlayView)
        addSubview(activityIndicator)
        addSubview(playerControlsView)
        playerControlsView.addSubview(currentTimeLabel)
        playerControlsView.addSubview(timeSlider)
        playerControlsView.addSubview(leftTimeLabel)
        playerControlsView.addSubview(toggleVideoButton)
        playerControlsView.addSubview(backwardButton)
        playerControlsView.addSubview(forwardButton)
    }

    override func addConstraints() {
        playerOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        playerControlsView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(46)
        }

        currentTimeLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(8)
            $0.width.equalTo(30)
        }

        timeSlider.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.left.equalTo(currentTimeLabel.snp.right).offset(12)
        }

        leftTimeLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(30)
            $0.left.equalTo(timeSlider.snp.right).offset(12)
        }

        toggleVideoButton.snp.makeConstraints {
            $0.size.equalTo(25)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(2)
            $0.left.equalTo(backwardButton.snp.right).offset(12)
        }

        backwardButton.snp.makeConstraints {
            $0.size.equalTo(25)
            $0.centerY.equalTo(toggleVideoButton)
        }

        forwardButton.snp.makeConstraints {
            $0.size.equalTo(25)
            $0.left.equalTo(toggleVideoButton.snp.right).offset(12)
            $0.centerY.equalTo(toggleVideoButton)
        }
    }

    func show(_ data: CourseDetailVideoViewData) {
        setupPlayer(data.videoUrl)
        setupControls(data.timeText)
    }

    func playVideo() {
        player?.play()
        toggleVideoButton.setImage(.playerPause, for: .normal)
        isVideoPlaying = true
    }

    func pauseVideo() {
        player?.pause()
        toggleVideoButton.setImage(.playerPlay, for: .normal)
        isVideoPlaying = false
    }

    func backwardVideo(_ time: Float64) {
        guard let currentTime = player?.currentTime() else { return }
        var newTime = CMTimeGetSeconds(currentTime) - time
        newTime = newTime < 0 ? 0 : newTime
        seekTime(newTime)
    }

    func forwardVideo(_ time: Float64) {
        guard let duration = player?.currentItem?.duration, let currentTime = player?.currentTime() else { return }
        var newTime = CMTimeGetSeconds(currentTime) + time
        newTime = newTime > duration.seconds ? duration.seconds : newTime
        seekTime(newTime)
    }

    func showVideoLoading(_ on: Bool) {
        on ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    func showPlayerControls(_ on: Bool, delay: Double) {
        UIView.animate(withDuration: 0.25, delay: delay, options: .curveEaseOut, animations: { [weak self] in
            guard let self = self else { return }
            self.playerControlsView.alpha = on ? 1.0 : 0.0
        })
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath, let bufferingKey = VideoBufferingKey(rawValue: key) else { return }
        switch bufferingKey {
        case .playbackBufferEmpty:
            videoDelegate?.didStartVideoBuffering()
        case .playbackLikelyToKeepUp,
             .playbackBufferFull:
            videoDelegate?.didStopVideoBuffering()
        case .status:
            if player?.status == AVPlayer.Status.readyToPlay {
                videoDelegate?.didStartVideoPlaying()
            }
        }
    }
}

// MARK: - Actions

private extension CourseDetailVideoView {
    @objc func didTapPlayPauseButton() {
        if isVideoPlaying {
            videoDelegate?.didTapPauseButton()
        } else {
            videoDelegate?.didTapPlayButton()
        }
    }

    @objc func didTapBackwardButton() {
        videoDelegate?.didTapBackwardButton()
    }

    @objc func didTapForwardButton() {
        videoDelegate?.didTapForwardButton()
    }

    @objc func didTapVideo() {
        if playerControlsView.alpha == 1.0 {
            videoDelegate?.didTapHidePlayerControls()
        } else {
            videoDelegate?.didTapShowPlayerControls()
        }
    }
}

// MARK: - Private

private extension CourseDetailVideoView {
    func setupPlayer(_ url: URL?) {
        guard let url = url else { return }

        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        layer.insertSublayer(playerLayer, at: 0)

        self.player = player
        self.playerLayer = playerLayer

        playVideo()
    }

    func setupControls(_ timeLabel: String) {
        backwardButton.setTitle(timeLabel, for: .normal)
        forwardButton.setTitle(timeLabel, for: .normal)
    }

    func seekTime(_ time: Double) {
        player?.pause()
        player?.seek(to: CMTimeMake(value: Int64(time), timescale: 1))
        if isVideoPlaying {
            player?.play()
        }
    }

    func addVideoObservers() {
        addPeriodicTimeObserver()
        addBufferObserver()
        addPlayerDidFinishPlayingNotification()
    }

    func removeVideoObservers() {
        removePeriodicTimeObserver()
        removeBufferObserver()
        removePlayerDidFinishPlayingNotification()
    }

    func addPeriodicTimeObserver() {
        let interval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let self = self, let currentItem = self.player?.currentItem, !currentItem.duration.seconds.isNaN else { return }
            self.timeSlider.maximumValue = Float(currentItem.duration.seconds)
            self.timeSlider.value = Float(currentItem.currentTime().seconds)
            let leftTime = currentItem.duration.seconds - currentItem.currentTime().seconds
            self.leftTimeLabel.text = leftTime.time
            self.currentTimeLabel.text = currentItem.currentTime().seconds.time
        })
    }

    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }

    func addBufferObserver() {
        player?.currentItem?.addObserver(self,
                                         forKeyPath: VideoBufferingKey.playbackBufferEmpty.rawValue,
                                         options: .new,
                                         context: nil)
        player?.currentItem?.addObserver(self,
                                         forKeyPath: VideoBufferingKey.playbackLikelyToKeepUp.rawValue,
                                         options: .new,
                                         context: nil)
        player?.currentItem?.addObserver(self,
                                         forKeyPath: VideoBufferingKey.playbackBufferFull.rawValue,
                                         options: .new,
                                         context: nil)
        player?.addObserver(self,
                            forKeyPath: VideoBufferingKey.status.rawValue,
                            options: .new,
                            context: nil)
    }

    func removeBufferObserver() {
        player?.currentItem?.removeObserver(self, forKeyPath: VideoBufferingKey.playbackBufferEmpty.rawValue)
        player?.currentItem?.removeObserver(self, forKeyPath: VideoBufferingKey.playbackLikelyToKeepUp.rawValue)
        player?.currentItem?.removeObserver(self, forKeyPath: VideoBufferingKey.playbackBufferFull.rawValue)
        player?.removeObserver(self, forKeyPath: VideoBufferingKey.status.rawValue)
    }

    func addPlayerDidFinishPlayingNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)
    }

    func removePlayerDidFinishPlayingNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                  object: player?.currentItem)
    }

    @objc func playerDidFinishPlaying() {
        isVideoPlaying = false
        toggleVideoButton.setImage(.playerPlay, for: .normal)
        timeSlider.value = 0
        player?.seek(to: .zero)
    }
}
