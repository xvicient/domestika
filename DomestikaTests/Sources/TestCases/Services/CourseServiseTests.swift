//
//  CourseServiseTests.swift
//  DomestikaTests
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import Domestika

class CourseServiseTests: XCTestCase {
    private let container = DependencyInjectionFactory.make(DependenciesRegistration())
    private var service: CourseServiceApi!

    override func setUp() {
        super.setUp()
        service = container.resolve(CourseServiceApi.self)
        HTTPStubs.removeAllStubs()
    }

    func test_coursesRequestSuccess() {
        ApiStub.stubRequest("courses", statusCode: 200, target: self)
        let expectation = self.expectation(description: "Service called and matches")

        service.courses {
            switch $0 {
            case let .success(courses):
                XCTAssertTrue(courses[0].id == "387")
                XCTAssertTrue(courses[0].thumbnailUrl == "http://domestika.org")
                XCTAssertTrue(courses[0].title == "Introduction to Adobe Photoshop")
                XCTAssertTrue(courses[0].trailerUrl == "https://player.vimeo.com")
                XCTAssertTrue(courses[0].description == "Learn Adobe Photoshop.")
                XCTAssertTrue(courses[0].location == "Barcelona, Spain")
                XCTAssertTrue(courses[0].teacher.name == "Carles Marsal")
                XCTAssertTrue(courses[0].teacher.avatarUrl == "http://domestika.org")
                XCTAssertTrue(courses[0].reviews.positive == 4008)
                XCTAssertTrue(courses[0].reviews.total == 4100)
                XCTAssertTrue(courses[0].lessonsCount == 50)
                XCTAssertTrue(courses[0].students == 161905)
                XCTAssertTrue(courses[0].audio == "Spanish")
                XCTAssertTrue(courses[0].subtitles[0] == "English")
                XCTAssertTrue(courses[0].level == "Beginner")
            case .failure:
                XCTFail("Shouldn't fail")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5, handler: .none)
    }

    func test_coursesRequestFailure() {
        ApiStub.stubRequest("courses", statusCode: 500, target: self)
        let expectation = self.expectation(description: "Service called and matches")

        service.courses {
            switch $0 {
            case .success:
                XCTFail("Shouldn't succeed")
            case let .failure(error):
                XCTAssertNotNil(error, "Should throw error")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5, handler: .none)
    }
}
