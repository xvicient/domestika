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

    override public func addSubviews() {
        addCourseImageView()
    }

    func setup(_ course: HomeViewMainCourse) {
        guard let imageURL = course.imageURL else { return }
        courseImageView.load(url: imageURL)
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
}
