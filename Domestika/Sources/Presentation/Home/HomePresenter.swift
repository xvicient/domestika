//
//  HomePresenter.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import Foundation

final class HomePresenter {
    private weak var view: HomeViewProtocol!
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
    private let locales: HomeLocales
    private var mainCourses = [Course]()
    private var popularCourses = [Course]()
    
    init(view: HomeViewProtocol,
         interactor: HomeInteractorProtocol,
         router: HomeRouterProtocol,
         locales: HomeLocales) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.locales = locales
    }
}

// MARK: - HomePresenterProtocol

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        showCourses()
    }

    func didSelectMainCourse(_ index: Int) {
        router.showCourse(mainCourses[index])
    }

    func didSelectPopularCourse(_ index: Int) {
        router.showCourse(popularCourses[index])
    }
}

// MARK: - Private

private extension HomePresenter {
    func showCourses() {
        interactor.courses { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(courses):
                self.showMainCourses(courses)
                self.showPopularCourses(courses)
            case .failure:
                self.router.show(self.locales.genericErrorMessage, okTitle: self.locales.alertOkTitle)
            }
        }
    }

    func showMainCourses(_ courses: [Course]) {
        mainCourses = Array(courses.prefix(4))
        let courses = mainCourses.map {
            HomeViewMainCourse(imageURL: URL(string: $0.thumbnailUrl),
                               title: $0.title,
                               watchCourseTitle: locales.watchMainCourseTitle)
        }
        view.render(state: .showMainCourses(courses))
    }

    func showPopularCourses(_ courses: [Course]) {
        popularCourses = Array(courses.dropFirst(4))
        let courses = popularCourses.map {
            HomeViewPopularCourse(imageURL: URL(string: $0.thumbnailUrl),
                                  title: $0.title,
                                  teacher: $0.teacher.name,
                                  watchCourseTitle: locales.watchMainCourseTitle)
        }
        let popularCourseData = HomeViewPopularCourseData(courses: courses,
                                                          popularCourseTitle: locales.popularCourseTitle)
        view.render(state: .showPopularCourses(popularCourseData))
    }
}
