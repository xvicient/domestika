//
//  DomainProtocols.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

protocol Domain {
    associatedtype T
    func toDomain() -> T
}
