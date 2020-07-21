//
//  HomeInteractor.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import Foundation

final class HomeInteractor {
    let courseService: CourseServiceApi

    init(courseService: CourseServiceApi) {
        self.courseService = courseService
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    func courses(completion: @escaping (Result<[Course], APIError>) -> Void) {
        courseService.courses(completion: completion)
    }
}
