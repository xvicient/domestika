//
//  Endpoint+Courses.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

extension Endpoint {
    static var courses: Endpoint {
        Endpoint(path: "challenge/home.json",
                 method: .get,
                 headers: nil,
                 queryParams: nil,
                 body: nil)
    }
}
