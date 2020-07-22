//
//  HomeView.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

enum HomeViewCourseSection {
    case main
    case popular
}

final class HomeView: DOView {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()

    private lazy var mainCoursesView: HomeMainCoursesView = {
        HomeMainCoursesView()
    }()

    private lazy var popularCoursesView: HomePopularCoursesView = {
        HomePopularCoursesView()
    }()

    override public func setup() {
        backgroundColor = .white
    }

    override public func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(mainCoursesView)
        stackView.addArrangedSubview(popularCoursesView)
    }

    override public func addConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(self)
            $0.height.equalTo(self).priority(250)
        }

        stackView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(contentView)
            $0.bottom.equalTo(contentView).offset(-40)
        }

        mainCoursesView.snp.makeConstraints {
            $0.height.equalTo(450)
        }

        popularCoursesView.snp.makeConstraints {
            $0.height.equalTo(325)
        }
    }

    func showMainCourses(_ courses: [HomeViewMainCourse]) {
        mainCoursesView.courses = courses
    }

    func showPopularCourses(_ data: HomeViewPopularCourseData) {
        popularCoursesView.data = data
    }
}
