//
//  CourseService.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

// MARK: - CourseServiceApi

// sourcery: AutoMockable
protocol CourseServiceApi {
    func courses(completion: @escaping (Result<[Course], APIError>) -> Void)
}

// MARK: - CourseService

struct CourseService {
    private let apiClient: APIClientApi

    init(apiClient: APIClientApi) {
        self.apiClient = apiClient
    }
}

extension CourseService: CourseServiceApi {
    func courses(completion: @escaping (Result<[Course], APIError>) -> Void) {
        apiClient.request(.courses) { (result: Result<[CourseCodable], APIError>) in
            completion(result.map { $0.map { $0.toDomain() }})
        }
    }
}
