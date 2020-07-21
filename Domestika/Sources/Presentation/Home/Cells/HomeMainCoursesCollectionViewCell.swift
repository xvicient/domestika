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
        let courseImageView = UIImageView()
        courseImageView.contentMode = .scaleAspectFill
        courseImageView.layer.masksToBounds = true
        return courseImageView
    }()

    private lazy var watchButton: UIButton = {
        let watchButton = UIButton()
        watchButton.backgroundColor = .white
        watchButton.setTitleColor(.darkGray, for: .normal)
        watchButton.roundCorners(radius: 2.0)
        watchButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .heavy)
        return watchButton
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .systemGray4
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        return titleLabel
    }()

    override public func addSubviews() {
        addCourseImageView()
        addWatchButton()
        addTitleLabel()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        courseImageView.addGradient(.vertical, colors: [.clear, UIColor.black.withAlphaComponent(0.75)])
    }

    func setup(_ course: HomeViewMainCourse, watchButtonTitle: String) {
        titleLabel.text = course.title
        watchButton.setTitle(watchButtonTitle, for: .normal)
        if let imageURL = course.imageURL {
            courseImageView.load(url: imageURL)
        }
    }
}

// MARK: - Life cycle

private extension HomeMainCoursesCollectionViewCell {
    func addCourseImageView() {
        contentView.addSubview(courseImageView)
        courseImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }

    func addWatchButton() {
        courseImageView.addSubview(watchButton)
        watchButton.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(35)
            $0.centerX.equalTo(courseImageView)
            $0.bottom.equalTo(courseImageView).offset(-55)
        }
    }

    func addTitleLabel() {
        courseImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(courseImageView).multipliedBy(0.7)
            $0.centerX.equalTo(courseImageView)
            $0.bottom.equalTo(watchButton.snp.top).offset(-10)
        }
    }
}
