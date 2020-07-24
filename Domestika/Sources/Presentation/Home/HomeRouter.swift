//
//  HomeRouter.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit

final class HomeRouter {
    private weak var viewController: UIViewController!
    private let container: DependencyInjectionApi

    init(viewController: UIViewController, container: DependencyInjectionApi) {
        self.viewController = viewController
        self.container = container
    }
}

extension HomeRouter: HomeRouterProtocol {
    func show(_ message: String, okTitle: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okTitle, style: .default))
        viewController.present(alertController, animated: true)
    }

    func showCourse(_ course: Course) {
        let courseDetailController = CourseDetailBuilder(container: container).buildModule(course)
        viewController.show(courseDetailController, sender: nil)
    }
}
