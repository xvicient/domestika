//
//  DOViewCell.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

public class DOViewCell: UICollectionViewCell {
    override public class var requiresConstraintBasedLayout: Bool { return true }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.autoresizingMask = .flexibleHeight

        setup()
        addSubviews()
        addConstraints()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {}

    func addSubviews() {}

    func addConstraints() {}
}
