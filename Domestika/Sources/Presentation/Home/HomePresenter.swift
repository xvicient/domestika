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
}

// MARK: - Private

private extension HomePresenter {
    func showCourses() {
        interactor.courses { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(courses):
                let data = HomeViewMainCourseData(courses: courses, watchButtonTitle: self.locales.watchButtonTitle)
                self.view.render(state: .showMainCourses(data))
            case .failure:
                break
            }
        }
    }
}
