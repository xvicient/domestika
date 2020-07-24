//
//  HomeMainCoursesView.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit
import SnapKit

struct HomeViewMainCourse: Equatable {
    let imageURL: URL?
    let title: String
    let watchCourseTitle: String
}

protocol HomeMainCoursesViewDelegate: class {
    func didSelectMainCourse(_ index: Int)
}

class HomeMainCoursesView: DOView {

    weak var coursesDelegate: HomeMainCoursesViewDelegate?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(HomeMainCoursesCollectionViewCell.self)
        view.delegate = self
        view.dataSource = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var pageControl: UIPageControl = {
        UIPageControl()
    }()

    var courses = [HomeViewMainCourse]() {
        didSet {
            pageControl.numberOfPages = courses.count
            collectionView.reloadData()
        }
    }

    override func setup() {
        backgroundColor = .clear
    }

    override func addSubviews() {
        addSubview(collectionView)
        addSubview(pageControl)
    }

    override func addConstraints() {
        pageControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - UICollectionViewDelegate && UICollectionViewDataSource && UICollectionViewDelegateFlowLayout

extension HomeMainCoursesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        courses.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeMainCoursesCollectionViewCell = collectionView.dequeue(for: indexPath)
        cell.setup(courses[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coursesDelegate?.didSelectMainCourse(indexPath.row)
    }
}
