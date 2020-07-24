//
//  CourseDetailView.swift
//  Domestika
//
//  Created by Xavier on 23/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

protocol CourseDetailViewDelegate: class {
    func didTapPlayButton()
    func didTapPauseButton()
    func didTapBackwardButton()
    func didTapForwardButton()
}

struct CourseDetailViewData: Equatable {
    let imageUrl: URL?
    let videoUrl: URL?
    let title: String
    let description: String
    let teacher: String
    let teacherAvatarUrl: URL?
    let location: String
    let data: [CourseDetailItemViewData]
}

final class CourseDetailView: DOView {

    weak var detailViewDelegate: CourseDetailViewDelegate?

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.bounces = false
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()

    private lazy var contentView: UIView = {
        UIView()
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()

    private lazy var videoView: CourseDetailVideoView = {
        let view = CourseDetailVideoView()
        view.videoDelegate = self
        return view
    }()

    private lazy var informationView: CourseDetailInformationView = {
        CourseDetailInformationView()
    }()

    override func setup() {
        backgroundColor = .white
    }

    override func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(videoView)
        stackView.addArrangedSubview(informationView)
    }

    override func addConstraints() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(self)
            $0.height.equalTo(self).priority(250)
        }

        stackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }

        videoView.snp.makeConstraints {
            $0.height.equalTo(225)
        }
    }

    func show(_ data: CourseDetailViewData) {
        videoView.show(data)
        informationView.show(data)
    }

    func playVideo () {
        videoView.playVideo()
    }

    func pauseVideo () {
        videoView.pauseVideo()
    }

    func backwardVideo(_ time: Float64) {
        videoView.backwardVideo(time)
    }

    func forwardVideo(_ time: Float64) {
        videoView.forwardVideo(time)
    }
}

// MARK: - CourseDetailVideoViewDelegate

extension CourseDetailView: CourseDetailVideoViewDelegate {
    func didTapPlayButton() {
        detailViewDelegate?.didTapPlayButton()
    }
    
    func didTapPauseButton() {
        detailViewDelegate?.didTapPauseButton()
    }
    
    func didTapBackwardButton() {
        detailViewDelegate?.didTapBackwardButton()
    }
    
    func didTapForwardButton() {
        detailViewDelegate?.didTapForwardButton()
    }
}
