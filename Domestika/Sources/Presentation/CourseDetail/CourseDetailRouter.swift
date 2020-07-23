//
//  CourseDetailRouter.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit

final class CourseDetailRouter {
    private weak var viewController: UIViewController!
    private let container: DependencyInjectionApi
    
    init(viewController: UIViewController, container: DependencyInjectionApi) {
        self.viewController = viewController
        self.container = container
    }
}

extension CourseDetailRouter: CourseDetailRouterProtocol {}
