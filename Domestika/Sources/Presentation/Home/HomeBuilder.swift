//
//  HomeBuilder.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit

final class HomeBuilder {
    private let container: DependencyInjectionApi

    init(container: DependencyInjectionApi) {
        self.container = container
    }
}

extension HomeBuilder: HomeBuilderProtocol {
    func buildModule() -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor(courseService: container.resolve(CourseServiceApi.self))
        let router = HomeRouter(viewController: view, container: container)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router, locales: HomeLocales())

        view.presenter = presenter
        
        return view
    }
}
