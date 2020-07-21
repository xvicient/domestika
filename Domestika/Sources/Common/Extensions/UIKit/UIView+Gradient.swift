//
//  UIView+Gradient.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

extension UIView {
    private var gradientLayerName: String {
        "gradientLayer"
    }

    enum GradientDirection {
        case vertical
        case horizontal
    }

    func addGradient(_ direction: GradientDirection, colors: [UIColor]) {
        removeGradient()
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.name = gradientLayerName
        switch direction {
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func removeGradient() {
        layer.sublayers?.filter { $0.name == gradientLayerName }.forEach { $0.removeFromSuperlayer() }
    }
}
