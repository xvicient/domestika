//
//  CourseDetailInformationView.swift
//  Domestika
//
//  Created by Xavier on 23/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

protocol CourseDetailInformationViewData {
    var title: String { get }
    var description: String { get }
    var teacher: String { get }
    var teacherAvatarUrl: URL? { get }
    var location: String { get }
    var data: [CourseDetailViewItemData] { get }
}

extension CourseDetailViewData: CourseDetailInformationViewData {}

class CourseDetailInformationView: DOView {
    private lazy var containerView: UIView = {
        UIView()
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        label.numberOfLines = 2
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        label.numberOfLines = 0
        return label
    }()

    private lazy var teacherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        label.numberOfLines = 1
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        label.numberOfLines = 1
        return label
    }()

    private lazy var teacherAvatarView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.roundCorners(radius: 20.0)
        view.backgroundColor = .systemGray6
        return view
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()

    override func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(teacherLabel)
        containerView.addSubview(locationLabel)
        containerView.addSubview(teacherAvatarView)
        containerView.addSubview(separatorView)
        containerView.addSubview(stackView)
    }

    override func addConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        teacherLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(34)
            $0.leading.equalToSuperview()
        }

        locationLabel.snp.makeConstraints {
            $0.top.equalTo(teacherLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview()
        }

        teacherAvatarView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.left.greaterThanOrEqualTo(teacherLabel.snp.right).offset(8)
            $0.left.greaterThanOrEqualTo(locationLabel.snp.right).offset(8)
            $0.centerY.equalTo(locationLabel)
            $0.size.equalTo(40)
        }

        separatorView.snp.makeConstraints {
            $0.top.equalTo(teacherAvatarView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func show(_ data: CourseDetailInformationViewData) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        teacherLabel.text = data.teacher
        locationLabel.text = data.location
        if let url = data.teacherAvatarUrl {
            teacherAvatarView.load(url: url)
        }
        data.data.forEach {
            let itemView = CourseDetailItemView()
            stackView.addArrangedSubview(itemView)
            itemView.show($0)
        }
    }
}
