//
//  CourseDetailItemView.swift
//  Domestika
//
//  Created by Xavier on 23/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

struct CourseDetailViewItemData: Equatable {
    let iconKey: String
    let title: String
    let subtitle: String?

    init(iconKey: String, title: String, subtitle: String? = nil) {
        self.iconKey = iconKey
        self.title = title
        self.subtitle = subtitle
    }
}

class CourseDetailItemView: DOView {
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 12
        return view
    }()

    private lazy var iconView: UIImageView = {
        UIImageView()
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        label.numberOfLines = 1
        return label
    }()

    private lazy var subtitleLabel: UIInsetLabel = {
        let label = UIInsetLabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10.0, weight: .bold)
        label.numberOfLines = 1
        label.isHidden = true
        label.backgroundColor = .systemOrange
        label.roundCorners(radius: 8.0)
        label.contentInsets = UIEdgeInsets(top: 6.0, left: 6.0, bottom: 6.0, right: 6.0)
        return label
    }()

    override func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }

    override func addConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }

        iconView.snp.makeConstraints {
            $0.size.equalTo(16)
        }
    }

    func show(_ data: CourseDetailViewItemData) {
        iconView.image = UIImage(named: data.iconKey)
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        subtitleLabel.isHidden = data.subtitle == nil
        titleLabel.snp.updateConstraints {
            $0.width.equalTo(titleLabel.intrinsicContentSize.width)
        }
    }
}
