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
        let view = UIScrollView()
        view.bounces = false
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()

    private lazy var contentView: UIView = {
        UIView()
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 40
        return view
    }()

    private lazy var mainCoursesView: HomeMainCoursesView = {
        let view = HomeMainCoursesView()
        view.coursesDelegate = self
        return view
    }()

    private lazy var popularCoursesView: HomePopularCoursesView = {
        let view = HomePopularCoursesView()
        view.coursesDelegate = self
        return view
    }()

    override func setup() {
        backgroundColor = .white
    }

    override func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(mainCoursesView)
        stackView.addArrangedSubview(popularCoursesView)
    }

    override func addConstraints() {
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
            $0.bottom.equalTo(contentView).inset(40)
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
