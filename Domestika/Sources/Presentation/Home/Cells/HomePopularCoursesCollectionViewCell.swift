//
//  HomePopularCoursesCollectionViewCell.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

class HomePopularCoursesCollectionViewCell: DOViewCell {

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.addShadow()
        return containerView
    }()

    private lazy var courseImageView: UIImageView = {
        let courseImageView = UIImageView()
        courseImageView.contentMode = .scaleAspectFill
        courseImageView.layer.masksToBounds = true
        courseImageView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 4.0)
        return courseImageView
    }()

    private lazy var detailView: UIView = {
        let detailView = UIView()
        detailView.backgroundColor = .white
        detailView.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 4.0)
        return detailView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        return titleLabel
    }()

    private lazy var teacherLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        return titleLabel
    }()

    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray6
        return separatorView
    }()

    private lazy var watchCourseLabel: UILabel = {
        let showCourseLabel = UILabel()
        showCourseLabel.numberOfLines = 1
        showCourseLabel.textColor = .darkGray
        showCourseLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        return showCourseLabel
    }()

    private lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.tintColor = .gray
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.layer.masksToBounds = true
        return arrowImageView
    }()

    override public func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(courseImageView)
        containerView.addSubview(detailView)
        detailView.addSubview(titleLabel)
        detailView.addSubview(teacherLabel)
        detailView.addSubview(separatorView)
        detailView.addSubview(watchCourseLabel)
        detailView.addSubview(arrowImageView)
    }

    override public func addConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalTo(contentView).inset(UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
        }

        courseImageView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(containerView)
            $0.height.equalTo(contentView).multipliedBy(0.5)
        }

        detailView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(containerView)
            $0.height.equalTo(contentView).multipliedBy(0.5)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
        }

        teacherLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
        }

        separatorView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(teacherLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }

        watchCourseLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().offset(-16)
        }

        arrowImageView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.left.equalTo(watchCourseLabel.snp.right).offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.width.equalTo(14)
            $0.height.equalTo(14)
        }
    }

    func setup(_ course: HomeViewPopularCourse) {
        titleLabel.text = course.title
        teacherLabel.text = course.teacher
        watchCourseLabel.text = course.watchCourseTitle
        if let imageURL = course.imageURL {
            courseImageView.load(url: imageURL)
        }
    }
}
