//
//  CourseDetailBuilder.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit

final class CourseDetailBuilder {
    private let container: DependencyInjectionApi

    init(container: DependencyInjectionApi) {
        self.container = container
    }
}

extension CourseDetailBuilder: CourseDetailBuilderProtocol {
    func buildModule(_ course: Course) -> UIViewController {
        let view = CourseDetailViewController()
        let interactor = CourseDetailInteractor()
        let router = CourseDetailRouter(viewController: view, container: container)
        let presenter = CourseDetailPresenter(view: view,
                                              interactor: interactor,
                                              router: router,
                                              locales: CourseDetailLocales(),
                                              course: course)

        view.presenter = presenter
        
        return view
    }
}
