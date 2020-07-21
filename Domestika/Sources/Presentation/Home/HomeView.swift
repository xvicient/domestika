//
//  HomeView.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

final class HomeView: DOView {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var mainCoursesCollectionView: HomeMainCoursesCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = HomeMainCoursesCollectionView(frame: .zero,
                                                           collectionViewLayout: layout)
        return collectionView
    }()

    override public func setup() {
        backgroundColor = .white
    }

    override public func addSubviews() {
        addScrollView()
        addStackView()
        addTopCollectionView()
    }

    func showTopCourses(_ courses: [HomeViewMainCourse]) {
        mainCoursesCollectionView.courses = courses
    }
}

// MARK: - Life cycle

private extension HomeView {
    func addScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(self)
            $0.height.equalTo(self).priority(250)
        }
    }

    func addStackView() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }

    func addTopCollectionView() {
        stackView.addArrangedSubview(mainCoursesCollectionView)
        mainCoursesCollectionView.snp.makeConstraints {
            $0.width.equalTo(stackView)
            $0.height.equalTo(400)
        }
    }
}
