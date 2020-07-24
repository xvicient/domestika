//
//  CourseMock.swift
//  DomestikaTests
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import Foundation

@testable import Domestika

struct CourseMock {
    static var course: Course {
        course()
    }

    static func courses(_ count: Int) -> [Course] {
        var courses = [Course]()
        for index in 1...count {
            courses.append(course(index))
        }
        return courses
    }

    private static func course(_ index: Int = 1) -> Course {
        Course(id: "\(index)",
            thumbnailUrl: "thumbnailUrl\(index)",
            title: "title\(index)",
            trailerUrl: "trailerUrl\(index)",
            description: "description\(index)",
            location: "location\(index)",
            teacher: Teacher(name: "name\(index)", avatarUrl: "avatarUrl\(index)"),
            reviews: Reviews(positive: 5, total: 10),
            lessonsCount: 10,
            students: 20,
            audio: "audio\(index)",
            subtitles: ["subtitles1\(index)", "subtitles2\(index)"],
            level: "level\(index)")
    }
}
