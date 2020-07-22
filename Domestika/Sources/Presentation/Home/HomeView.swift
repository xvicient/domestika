//
//  HomeView.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

protocol HomeViewDelegate: class {
    func didSelectMainCourse(_ index: Int)
    func didSelectPopularCourse(_ index: Int)
}

final class HomeView: DOView {

    weak var homeDelegate: HomeViewDelegate?

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
        let mainCoursesView = HomeMainCoursesView()
        mainCoursesView.coursesDelegate = self
        return mainCoursesView
    }()

    private lazy var popularCoursesView: HomePopularCoursesView = {
        let popularCoursesView = HomePopularCoursesView()
        popularCoursesView.coursesDelegate = self
        return popularCoursesView
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

// MARK: - HomeMainCoursesViewDelegate && HomePopularCoursesViewDelegate

extension HomeView: HomeMainCoursesViewDelegate, HomePopularCoursesViewDelegate {
    func didSelectMainCourse(_ index: Int) {
        homeDelegate?.didSelectMainCourse(index)
    }

    func didSelectPopularCourse(_ index: Int) {
        homeDelegate?.didSelectPopularCourse(index)
    }
}
