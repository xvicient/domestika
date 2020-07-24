//
//  ApiStub.swift
//  DomestikaTests
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import Domestika

struct ApiStub {
    static func stubRequest(_ service: String, statusCode: Int32, target: XCTestCase) {
        let container = DependencyInjectionFactory.make(DependenciesRegistration())
        guard let host = URL(string: container.resolve(APIClientApi.self).baseURL)?.host,
            let fileAtPath = OHPathForFile("\(service).json", type(of: target)) else {
                abort()
        }
        stub(condition: isHost(host)) { _ in
            HTTPStubsResponse(fileAtPath: fileAtPath,
                              statusCode: statusCode,
                              headers: ["Content-Type": "application/json"])
        }
    }
}
