//
//  TeacherCodable.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

struct TeacherCodable: Codable, Domain {
    let name: String
    let avatarUrl: String

    func toDomain() -> Teacher {
        Teacher(name: name, avatarUrl: avatarUrl)
    }
}
