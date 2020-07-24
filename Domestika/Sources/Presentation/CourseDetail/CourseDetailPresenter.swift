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
    private let locales: CourseDetailLocales
    private let backwardForwardTime: Float64 = 10
    
    init(view: CourseDetailViewProtocol,
         interactor: CourseDetailInteractorProtocol,
         router: CourseDetailRouterProtocol,
         locales: CourseDetailLocales,
         course: Course) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.locales = locales
        self.course = course
    }
}

// MARK: - CourseDetailPresenterProtocol

extension CourseDetailPresenter: CourseDetailPresenterProtocol {
    func viewDidLoad() {
        renderView()
    }

    func didTapPlayButton() {
        view.render(state: .playVideo)
    }

    func didTapPauseButton() {
        view.render(state: .pauseVideo)
    }

    func didTapBackwardButton() {
        view.render(state: .backwardVideo(backwardForwardTime))
    }

    func didTapForwardButton() {
        view.render(state: .forwardVideo(backwardForwardTime))
    }
}

// MARK: - Private

private extension CourseDetailPresenter {
    func renderView() {
        let videoData = CourseDetailVideoViewData(videoUrl: URL(string: course.trailerUrl),
                                                  backwardForwardTime: backwardForwardTime)
        let data = CourseDetailViewData(videoData: videoData,
                                        title: course.title,
                                        description: course.description,
                                        teacher: course.teacher.name,
                                        teacherAvatarUrl: URL(string: course.teacher.avatarUrl),
                                        location: course.location,
                                        data: courseData(course))
        view.render(state: .show(data))
    }

    func courseData(_ course: Course) -> [CourseDetailViewItemData] {
        let reviewPercentage = "\((course.reviews.positive * 100) / course.reviews.total)%"
        return [CourseDetailViewItemData(iconKey: "like", title: locales.coursePositiveReviews(reviewPercentage, count: course.reviews.positive)),
                CourseDetailViewItemData(iconKey: "lesson", title: locales.courseLessons(course.lessonsCount)),
                CourseDetailViewItemData(iconKey: "user", title: locales.courseStudents(course.students)),
                CourseDetailViewItemData(iconKey: "audio", title: locales.courseAudio(course.audio)),
                CourseDetailViewItemData(iconKey: "subtitle", title: course.subtitles.joined(separator: " / ")),
                CourseDetailViewItemData(iconKey: "level", title: locales.courseLevel, subtitle: course.level.uppercased())]
    }
}
