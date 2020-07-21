//
//  ReviewsCodable.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

struct ReviewsCodable: Codable, Domain {
    let positive: Int
    let total: Int

    func toDomain() -> Reviews {
        Reviews(positive: positive, total: total)
    }
}
