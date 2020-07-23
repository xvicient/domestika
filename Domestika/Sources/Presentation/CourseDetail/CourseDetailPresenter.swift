//
//  CourseDetailPresenter.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import Foundation

final class CourseDetailPresenter {
    private weak var view: CourseDetailViewProtocol!
    private let interactor: CourseDetailInteractorProtocol
    private let router: CourseDetailRouterProtocol
    private let course: Course
    
    init(view: CourseDetailViewProtocol,
         interactor: CourseDetailInteractorProtocol,
         router: CourseDetailRouterProtocol,
        course: Course) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.course = course
    }
}

// MARK: - CourseDetailPresenterProtocol

extension CourseDetailPresenter: CourseDetailPresenterProtocol {
    func viewDidLoad() {
        renderView()
    }
}

// MARK: - Private

private extension CourseDetailPresenter {
    func renderView() {
        let data = CourseDetailViewData(imageUrl: URL(string: course.thumbnailUrl),
                                        videoUrl: URL(string: course.trailerUrl),
                                        title: course.title,
                                        description: course.description,
                                        teacher: course.teacher.name,
                                        teacherAvatarUrl: URL(string: course.teacher.avatarUrl),
                                        location: course.location,
                                        information: [])
        view.render(state: .show(data))
    }
}
