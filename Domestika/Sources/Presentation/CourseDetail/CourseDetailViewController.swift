//
//  CourseDetailViewController.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit

final class CourseDetailViewController: UIViewController {
    var presenter: CourseDetailPresenterProtocol!

    private lazy var courseDetailView: CourseDetailView = {
        let courseDetailView = CourseDetailView(frame: view.frame)
        courseDetailView.detailViewDelegate = self
        return courseDetailView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        onViewDidLoad()
    }

    override func loadView() {
        super.loadView()
        view = courseDetailView
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
        }
    }
}

// MARK: - Private

private extension CourseDetailViewController {
    func onViewWillAppear() {
        navigationController?.isNavigationBarHidden = false
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share"), style: .plain, target: self, action: nil)
        shareButton.tintColor = .black
        navigationItem.rightBarButtonItem  = shareButton
    }

    func onViewDidLoad() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
    }

    func show(_ data: CourseDetailViewData) {
        courseDetailView.show(data)
    }

    func playVideo () {
        courseDetailView.playVideo()
    }

    func pauseVideo () {
        courseDetailView.pauseVideo()
    }

    func backwardVideo(_ time: Float64) {
        courseDetailView.backwardVideo(time)
    }

    func forwardVideo(_ time: Float64) {
        courseDetailView.forwardVideo(time)
    }
}

// MARK: - CourseDetailVideoViewDelegate

extension CourseDetailViewController: CourseDetailViewDelegate {
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
}
