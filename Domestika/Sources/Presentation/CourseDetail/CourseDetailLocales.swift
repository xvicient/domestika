//
//  CourseDetailLocales.swift
//  Domestika
//
//  Created by Xavier on 23/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

struct CourseDetailLocales {
    func coursePositiveReviews(_ percentage: String, count: Int) -> String {
        String(format: "course_positive_reviews".localized, percentage, count)
    }
    func courseLessons(_ count: Int) -> String {
        String(format: "course_lessons".localized, count)
    }
    func courseStudents(_ count: Int) -> String {
        String(format: "course_students".localized, count)
    }
    func courseAudio(_ audio: String) -> String {
        String(format: "course_audio".localized, audio)
    }
    let courseLevel = "course_level".localized
}
