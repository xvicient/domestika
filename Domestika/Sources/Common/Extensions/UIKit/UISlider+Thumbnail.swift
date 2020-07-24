//
//  UISlider+Thumbnail.swift
//  Domestika
//
//  Created by Xavier on 24/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

extension UISlider {
    func setThumbSize(_ size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        context?.addEllipse(in: CGRect(origin: .zero, size: size))
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setThumbImage(image, for: .normal)
        setThumbImage(image, for: .highlighted)
    }
}
