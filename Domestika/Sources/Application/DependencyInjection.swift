//
//  DependencyInjection.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import Swinject

protocol DependencyInjectionApi {
    func resolve<Service>(_ serviceType: Service.Type) -> Service
    func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service
    func resolve<Service>(_ serviceType: Service.Type, resetObjectScope: Bool) -> Service
    func clear()
}

protocol Dependencies {
    func register(_ container: Container)
}

enum DependencyInjectionFactory {
    static func make(_ dependencies: Dependencies) -> DependencyInjectionApi {
        DependencyInjection(dependencies: dependencies)
    }
}

extension ObjectScope {
    static let resettable = ObjectScope(storageFactory: PermanentStorage.init)
    static let unclearable = ObjectScope(storageFactory: PermanentStorage.init)
}

struct DependencyInjection: DependencyInjectionApi {
    let container: Container
    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        container = Container()
        self.dependencies = dependencies
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        if let service = container.synchronize().resolve(serviceType) {
            return service
        } else {
            dependencies.register(container)
            return container.synchronize().resolve(serviceType)!
        }
    }

    func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
        if let service = container.synchronize().resolve(serviceType, argument: argument) {
            return service
        } else {
            dependencies.register(container)
            return container.synchronize().resolve(serviceType)!
        }
    }

    func resolve<Service>(_ serviceType: Service.Type, resetObjectScope: Bool) -> Service {
        if resetObjectScope { container.resetObjectScope(.resettable) }
        return resolve(serviceType)
    }

    func clear() {
        container.resetObjectScope(.graph)
        container.resetObjectScope(.container)
        container.resetObjectScope(.resettable)
    }
}

