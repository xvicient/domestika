//
//  DependenciesRegistration.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import Swinject

struct DependenciesRegistration: Dependencies {
    func register(_ container: Container) {
        registerFoundation(container)
        registerServices(container)
    }

    func registerFoundation(_ container: Container) {
        container.register(URLSessionConfiguration.self) { _ in
            URLSessionConfiguration.default
        }
        container.register(URLSession.self) {
            URLSession(configuration: $0.resolve(URLSessionConfiguration.self)!)
        }
    }
    func registerServices(_ container: Container) {
        #if DEBUG
        container.register(APIClientLoggerApi.self) { _ in
            APIClientLoggerFactory.make()
        }
        #endif

        container.register(APIClientApi.self) {
            APIClientFactory.make(baseURL: "https://mobile-assets.domestika.org/",
                                  session: $0.resolve(URLSession.self)!,
                                  logger: $0.resolve(APIClientLoggerApi.self))
        }
        
        container.register(CourseServiceApi.self) {
            CourseService(apiClient: $0.resolve(APIClientApi.self)!)
        }
    }
}
