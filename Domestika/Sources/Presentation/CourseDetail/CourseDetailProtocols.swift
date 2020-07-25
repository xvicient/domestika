//
//  CourseDetailProtocols.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit

// MARK: - Builder

// sourcery: AutoMockable
protocol CourseDetailBuilderProtocol {
    func buildModule(_ course: Course) -> UIViewController
}

// MARK: - Router

// sourcery: AutoMockable
protocol CourseDetailRouterProtocol {}

// MARK: - Presenter

// sourcery: AutoMockable
protocol CourseDetailPresenterProtocol {
    func viewDidLoad()
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

// MARK: - Interactor

// sourcery: AutoMockable
protocol CourseDetailInteractorProtocol {}

// MARK: - View

enum CourseDetailViewState: Equatable {
    case show(_ data: CourseDetailViewData)
    case playVideo
    case pauseVideo
    case backwardVideo(_ time: Float64)
    case forwardVideo(_ time: Float64)
    case showVideoLoading(_ on: Bool)
    case showPlayerControls(_ on: Bool, delay: Double = 0.0)
}

// sourcery: AutoMockable
protocol CourseDetailViewProtocol: AnyObject {
    var presenter: CourseDetailPresenterProtocol! { get set }
    func render(state: CourseDetailViewState)
}
