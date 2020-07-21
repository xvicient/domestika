//
//  Course.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

struct Course {
    let id: String
    let thumbnailUrl: String
    let title: String
    let trailerUrl: String
    let description: String
    let location: String
    let teacher: Teacher
    let reviews: Reviews
    let lessonsCount: Int
    let students: Int
    let audio: String
    let subtitles: [String]
    let level: String
}
