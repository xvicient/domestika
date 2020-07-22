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
        Course(id: "1234",
               thumbnailUrl: "thumbnailUrl",
               title: "title",
               trailerUrl: "trailerUrl",
               description: "description",
               location: "location",
               teacher: Teacher(name: "name", avatarUrl: "avatarUrl"),
               reviews: Reviews(positive: 5, total: 10),
               lessonsCount: 10,
               students: 20,
               audio: "audio",
               subtitles: ["subtitles1", "subtitles2"],
               level: "level")
    }

    static func courses(_ count: Int) -> [Course] {
        var courses = [Course]()
        for index in 1...count {
            courses.append(Course(id: "\(index)",
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
                                  level: "level\(index)"))
        }
        return courses
    }
}
