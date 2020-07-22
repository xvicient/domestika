// 
//  HomeTests.swift
//  DomestikaTests
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import SwiftyMocky
import Swinject
import XCTest

@testable import Domestika

// MARK: - View tests

class HomeViewTests: XCTestCase {
    private var view: HomeViewController!
    private let presenterMock = HomePresenterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)

    override func setUp() {
        super.setUp()
        setupView()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension HomeViewTests {
    func setupView() {
        view = HomeViewController(nibName: nil, bundle: nil)
        view.presenter = presenterMock
    }
}

// MARK: - Presenter tests

class HomePresenterTests: XCTestCase {
    private var presenter: HomePresenter!
    private let interactorMock = HomeInteractorProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let routerMock = HomeRouterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let viewMock = HomeViewProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let locales = HomeLocales()
    private let coursesMock = CourseMock.courses(10)

    override func setUp() {
        super.setUp()
        setupPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_showCoursesSucceed() {
        mockCourses(.success(coursesMock))
        presenter.viewDidLoad()

        Verify(interactorMock, 1, .courses(completion: .any))

        let mainCourses = Array(coursesMock.prefix(4)).map {
            HomeViewMainCourse(imageURL: URL(string: $0.thumbnailUrl),
                               title: $0.title,
                               watchCourseTitle: locales.watchMainCourseTitle)
        }
        Verify(viewMock, 1, .render(state: .value(.showMainCourses(mainCourses))))

        let popularCourses = Array(coursesMock.dropFirst(4)).map {
            HomeViewPopularCourse(imageURL: URL(string: $0.thumbnailUrl),
                                  title: $0.title,
                                  teacher: $0.teacher.name,
                                  watchCourseTitle: locales.watchMainCourseTitle)
        }
        let popularCoursesData = HomeViewPopularCourseData(courses: popularCourses,
                                                           popularCourseTitle: locales.popularCourseTitle)
        Verify(viewMock, 1, .render(state: .value(.showPopularCourses(popularCoursesData))))
    }

    func test_showCoursesFailure() {
        mockCourses(.failure(APIError.httpCode(404, nil)))
        presenter.viewDidLoad()

        Verify(interactorMock, 1, .courses(completion: .any))
        Verify(routerMock, 1, .show(.value(locales.genericErrorMessage), okTitle: .value(locales.alertOkTitle)))
    }

    func test_showMainCourseDetail() {
        mockCourses(.success(coursesMock))
        presenter.viewDidLoad()

        let tapIndex = 0
        let mainCourses = Array(coursesMock.prefix(4))
        presenter.didTapCourse(tapIndex, section: .main)

        Verify(routerMock, 1, .showCourse(.value(mainCourses[tapIndex])))
    }

    func test_showPopularCourseDetail() {
        mockCourses(.success(coursesMock))
        presenter.viewDidLoad()

        let tapIndex = 0
        let popularCourses = Array(coursesMock.dropFirst(4))
        presenter.didTapCourse(tapIndex, section: .popular)

        Verify(routerMock, 1, .showCourse(.value(popularCourses[tapIndex])))
    }
}

private extension HomePresenterTests {
    func setupPresenter() {
        presenter = HomePresenter(view: viewMock, interactor: interactorMock, router: routerMock, locales: locales)
    }

    func mockCourses(_ result: Result<[Course], APIError>) {
        Perform(interactorMock, .courses(completion: .any,
                                         perform: { completion in
                                            completion(result)
        }))
    }
}

// MARK: - Interactor tests

class HomeInteractorTests: XCTestCase {
    private var interactor: HomeInteractor!
    private let presenterMock = HomePresenterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let courseServiceMock = CourseServiceApiMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)

    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension HomeInteractorTests {
    func setupInteractor() {
        interactor = HomeInteractor(courseService: courseServiceMock)
    }
}

// MARK: - Router tests

class HomeRouterTests: XCTestCase {
    private var router: HomeRouter!
    private let container: DependencyInjectionApi = DependencyInjectionFactory.make(DependenciesRegistration())

    override func setUp() {
        super.setUp()
        setupRouter()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension HomeRouterTests {
    func setupRouter() {
        router = HomeRouter(viewController: UIViewController(nibName: nil, bundle: nil), container: container)
    }
}
