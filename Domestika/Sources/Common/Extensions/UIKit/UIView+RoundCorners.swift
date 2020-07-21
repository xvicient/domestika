//
//  UIView+RoundCorners.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(_ corners: CACornerMask = [.layerMinXMinYCorner,
                                                 .layerMaxXMinYCorner,
                                                 .layerMinXMaxYCorner,
                                                 .layerMaxXMaxYCorner],
                      radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}
