// 
//  CourseDetailTests.swift
//  DomestikaTests
//
//  Created by Xavier on 24/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import SwiftyMocky
import Swinject
import XCTest

@testable import Domestika

// MARK: - View tests

class CourseDetailViewTests: XCTestCase {
    private var view: CourseDetailViewController!
    private let presenterMock = CourseDetailPresenterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)

    override func setUp() {
        super.setUp()
        setupView()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_viewLoaded() {
        view.viewDidLoad()
        Verify(presenterMock, .viewDidLoad())
    }

    func test_playButtonTapped() {
        view.didTapPlayButton()
        Verify(presenterMock, .didTapPlayButton())
    }

    func test_pauseButtonTapped() {
        view.didTapPauseButton()
        Verify(presenterMock, .didTapPauseButton())
    }

    func test_backwardButtonTapped() {
        view.didTapBackwardButton()
        Verify(presenterMock, .didTapBackwardButton())
    }

    func test_forwardButtonTapped() {
        view.didTapForwardButton()
        Verify(presenterMock, .didTapForwardButton())
    }

    func test_videoBufferingStarted() {
        view.didStartVideoBuffering()
        Verify(presenterMock, .didStartVideoBuffering())
    }

    func test_videoBufferingStopped() {
        view.didStopVideoBuffering()
        Verify(presenterMock, .didStopVideoBuffering())
    }
}

private extension CourseDetailViewTests {
    func setupView() {
        view = CourseDetailViewController()
        view.presenter = presenterMock
    }
}

// MARK: - Presenter tests

class CourseDetailPresenterTests: XCTestCase {
    private var presenter: CourseDetailPresenter!
    private let interactorMock = CourseDetailInteractorProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let routerMock = CourseDetailRouterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let viewMock = CourseDetailViewProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let locales = CourseDetailLocales()
    private let course = CourseMock.course
    private let backwardForwardTime: Float64 = 10

    override func setUp() {
        super.setUp()
        setupPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_showCourseDetail() {
        presenter.viewDidLoad()

        let videoData = CourseDetailVideoViewData(videoUrl: URL(string: course.trailerUrl),
                                                  backwardForwardTime: backwardForwardTime)
        let data = CourseDetailViewData(videoData: videoData,
                                        title: course.title,
                                        description: course.description,
                                        teacher: course.teacher.name,
                                        teacherAvatarUrl: URL(string: course.teacher.avatarUrl),
                                        location: course.location,
                                        data: courseData(course))
        
        Verify(viewMock, 1, .render(state: .value(.show(data))))
    }

    func test_playVideo() {
        presenter.didTapPlayButton()
        Verify(viewMock, 1, .render(state: .value(.playVideo)))
    }

    func test_pauseVideo() {
        presenter.didTapPauseButton()
        Verify(viewMock, 1, .render(state: .value(.pauseVideo)))
    }

    func test_backwardVideo() {
        presenter.didTapBackwardButton()
        Verify(viewMock, 1, .render(state: .value(.backwardVideo(backwardForwardTime))))
    }

    func test_forwardVideo() {
        presenter.didTapForwardButton()
        Verify(viewMock, 1, .render(state: .value(.forwardVideo(backwardForwardTime))))
    }

    func test_startBuffering() {
        presenter.didStartVideoBuffering()
        Verify(viewMock, 1, .render(state: .value(.showLoading(true))))
    }

    func test_stopBuffering() {
        presenter.didStopVideoBuffering()
        Verify(viewMock, 1, .render(state: .value(.showLoading(false))))
    }
}

private extension CourseDetailPresenterTests {
    func setupPresenter() {
        presenter = CourseDetailPresenter(view: viewMock, interactor: interactorMock, router: routerMock, locales: locales, course: course)
    }

    func courseData(_ course: Course) -> [CourseDetailViewItemData] {
        let reviewPercentage = "\((course.reviews.positive * 100) / course.reviews.total)%"
        return [CourseDetailViewItemData(iconKey: "like", title: locales.coursePositiveReviews(reviewPercentage, count: course.reviews.positive)),
                CourseDetailViewItemData(iconKey: "lesson", title: locales.courseLessons(course.lessonsCount)),
                CourseDetailViewItemData(iconKey: "user", title: locales.courseStudents(course.students)),
                CourseDetailViewItemData(iconKey: "audio", title: locales.courseAudio(course.audio)),
                CourseDetailViewItemData(iconKey: "subtitle", title: course.subtitles.joined(separator: " / ")),
                CourseDetailViewItemData(iconKey: "level", title: locales.courseLevel, subtitle: course.level.uppercased())]
    }
}

// MARK: - Interactor tests

class CourseDetailInteractorTests: XCTestCase {
    private var interactor: CourseDetailInteractor!
    private let presenterMock = CourseDetailPresenterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)

    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension CourseDetailInteractorTests {
    func setupInteractor() {
        interactor = CourseDetailInteractor()
    }
}

// MARK: - Router tests

class CourseDetailRouterTests: XCTestCase {
    private var router: CourseDetailRouter!
    private let container: DependencyInjectionApi = DependencyInjectionFactory.make(DependenciesRegistration())

    override func setUp() {
        super.setUp()
        setupRouter()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension CourseDetailRouterTests {
    func setupRouter() {
        router = CourseDetailRouter(viewController: UIViewController(nibName: nil, bundle: nil), container: container)
    }
}
