//
//  CourseDetailItemView.swift
//  Domestika
//
//  Created by Xavier on 23/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

struct CourseDetailItemViewData: Equatable {
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
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()

    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        return iconView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    private lazy var subtitleLabel: InsetLabel = {
        let subtitleLabel = InsetLabel()
        subtitleLabel.textColor = .white
        subtitleLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .bold)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.isHidden = true
        subtitleLabel.backgroundColor = .systemOrange
        subtitleLabel.roundCorners(radius: 8.0)
        subtitleLabel.contentInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        return subtitleLabel
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

    func show(_ data: CourseDetailItemViewData) {
        iconView.image = UIImage(named: data.iconKey)
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        subtitleLabel.isHidden = data.subtitle == nil
        titleLabel.snp.updateConstraints {
            $0.width.equalTo(titleLabel.intrinsicContentSize.width)
        }
    }
}
