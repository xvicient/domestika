//
//  String+Class.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

extension String {
    static func stringFromClass(_ objectClass: AnyClass) -> String {
        return NSStringFromClass(objectClass).components(separatedBy: ".").last!
    }
}
