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
    
    init(view: HomeViewProtocol,
         interactor: HomeInteractorProtocol,
         router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
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
                self.view.render(state: .showTopCourses(courses))
            case .failure:
                break
            }
        }
    }
}
