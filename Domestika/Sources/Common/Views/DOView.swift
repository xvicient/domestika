//
//  DOView.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

class DOView: UIView {
    override public class var requiresConstraintBasedLayout: Bool { return true }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addSubviews()
        addConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {}

    func addSubviews() {}

    func addConstraints() {}
}
