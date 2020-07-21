//
//  Course.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

struct CourseCodable: Codable, Domain {
    let id: String
    let thumbnailUrl: String
    let title: String
    let trailerUrl: String
    let description: String
    let location: String
    let teacher: TeacherCodable
    let reviews: ReviewsCodable
    let lessonsCount: Int
    let students: Int
    let audio: String
    let subtitles: [String]
    let level: String

    func toDomain() -> Course {
        Course(id: id,
               thumbnailUrl: thumbnailUrl,
               title: title,
               trailerUrl: trailerUrl,
               description: description,
               location: location,
               teacher: teacher.toDomain(),
               reviews: reviews.toDomain(),
               lessonsCount: lessonsCount,
               students: students,
               audio: audio,
               subtitles: subtitles,
               level: level)
    }
}
