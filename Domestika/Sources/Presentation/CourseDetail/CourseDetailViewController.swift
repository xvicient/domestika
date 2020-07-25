//
//  CourseDetailViewController.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit

struct CourseDetailViewData: Equatable {
    let videoData: CourseDetailVideoViewData
    let title: String
    let description: String
    let teacher: String
    let teacherAvatarUrl: URL?
    let location: String
    let data: [CourseDetailViewItemData]
}

final class CourseDetailViewController: UIViewController {
    var presenter: CourseDetailPresenterProtocol!

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
        view.distribution = .fill
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        onViewDidLoad()
    }
}

// MARK: - Life cycle

extension CourseDetailViewController {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(videoView)
        stackView.addArrangedSubview(informationView)
    }

    func addConstraints() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(view)
            $0.height.equalTo(view).priority(250)
        }

        stackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }

        videoView.snp.makeConstraints {
            $0.height.equalTo(225)
        }
    }
}

// MARK: - CourseDetailViewProtocol

extension CourseDetailViewController: CourseDetailViewProtocol {
    func render(state: CourseDetailViewState) {
        switch state {
        case let .show(data):
            show(data)
        case .playVideo:
            playVideo()
        case .pauseVideo:
            pauseVideo()
        case let .backwardVideo(time):
            backwardVideo(time)
        case let .forwardVideo(time):
            forwardVideo(time)
        case let .showVideoLoading(on):
            showVideoLoading(on)
        case let .showPlayerControls(on, delay):
            showPlayerControls(on, delay: delay)
        }
    }
}

// MARK: - Private

private extension CourseDetailViewController {
    func onViewWillAppear() {
        navigationController?.isNavigationBarHidden = false
        let shareButton = UIBarButtonItem(image: .share, style: .plain, target: self, action: nil)
        shareButton.tintColor = .black
        navigationItem.rightBarButtonItem = shareButton
    }

    func onViewDidLoad() {
        addSubviews()
        addConstraints()
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
    }

    func show(_ data: CourseDetailViewData) {
        videoView.show(data.videoData)
        informationView.show(data)
    }

    func playVideo() {
        videoView.playVideo()
    }

    func pauseVideo() {
        videoView.pauseVideo()
    }

    func backwardVideo(_ time: Float64) {
        videoView.backwardVideo(time)
    }

    func forwardVideo(_ time: Float64) {
        videoView.forwardVideo(time)
    }

    func showVideoLoading(_ on: Bool) {
        videoView.showVideoLoading(on)
    }

    func showPlayerControls(_ on: Bool, delay: Double) {
        videoView.showPlayerControls(on, delay: delay)
    }
}

// MARK: - CourseDetailVideoViewDelegate

extension CourseDetailViewController: CourseDetailVideoViewDelegate {
    func didTapPlayButton() {
        presenter.didTapPlayButton()
    }

    func didTapPauseButton() {
        presenter.didTapPauseButton()
    }

    func didTapBackwardButton() {
        presenter.didTapBackwardButton()
    }

    func didTapForwardButton() {
        presenter.didTapForwardButton()
    }

    func didTapShowPlayerControls() {
        presenter.didTapShowPlayerControls()
    }

    func didTapHidePlayerControls() {
        presenter.didTapHidePlayerControls()
    }

    func didStartVideoBuffering() {
        presenter.didStartVideoBuffering()
    }

    func didStopVideoBuffering() {
        presenter.didStopVideoBuffering()
    }

    func didStartVideoPlaying() {
        presenter.didStartVideoPlaying()
    }
}
