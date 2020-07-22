//
//  UIView+Shadow.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(radius: CGFloat = 4,
                   opacity: Float = 0.2,
                   color: UIColor = .lightGray,
                   offset: CGSize = CGSize(width: 0, height: 4)) {
        layer.masksToBounds = false
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
    }
}
