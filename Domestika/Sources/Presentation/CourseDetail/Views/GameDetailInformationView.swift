//
//  GameDetailInformationView.swift
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
    var information: [String] { get }
}

extension CourseDetailViewData: CourseDetailInformationViewData {}

class GameDetailInformationView: DOView {

    private lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    private lazy var descriptionLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    private lazy var teacherLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    private lazy var locationLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    private lazy var teacherAvatarView: UIImageView = {
        let teacherAvatarView = UIImageView()
        teacherAvatarView.contentMode = .scaleAspectFill
        teacherAvatarView.roundCorners(radius: teacherAvatarView.frame.size.width / 2)
        return teacherAvatarView
    }()

    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray6
        return separatorView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
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
            $0.height.equalTo(400)
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
            $0.top.equalTo(teacherAvatarView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
            $0.bottom.lessThanOrEqualToSuperview()
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
    }
}
