//
//  HomeMainCoursesCollectionViewCell.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

class HomeMainCoursesCollectionViewCell: DOViewCell {
    private lazy var courseImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var watchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.roundCorners(radius: 2.0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    override func addSubviews() {
        contentView.addSubview(courseImageView)
        courseImageView.addSubview(watchButton)
        courseImageView.addSubview(titleLabel)
    }

    override func addConstraints() {
        courseImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
            $0.bottom.equalTo(watchButton).offset(55)
        }

        watchButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(35)
            $0.centerX.equalTo(courseImageView)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }

        titleLabel.snp.makeConstraints {
            $0.width.equalTo(courseImageView).multipliedBy(0.7)
            $0.centerX.equalTo(courseImageView)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        courseImageView.addGradient(.vertical, colors: [.clear, UIColor.black.withAlphaComponent(0.75)])
    }

    func setup(_ course: HomeViewMainCourse) {
        titleLabel.text = course.title
        watchButton.setTitle(course.watchCourseTitle, for: .normal)
        if let imageURL = course.imageURL {
            courseImageView.load(url: imageURL)
        }
    }
}
