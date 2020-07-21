//
//  HomeMainCoursesView.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit
import SnapKit

struct HomeViewMainCourseData {
    let courses: [HomeViewMainCourse]
    let watchButtonTitle: String
}

protocol HomeViewMainCourse {
    var imageURL: URL? { get }
    var title: String { get }
}

extension Course: HomeViewMainCourse {
    var imageURL: URL? {
        URL(string: thumbnailUrl)
    }
}

class HomeMainCoursesView: DOView {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeMainCoursesCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        return pageControl
    }()

    var data: HomeViewMainCourseData? {
        didSet {
            pageControl.numberOfPages = data?.courses.count ?? 0
            collectionView.reloadData()
        }
    }

    override public func setup() {
        backgroundColor = .clear
    }

    override public func addSubviews() {
        addCollectionView()
        addPageControl()
    }

}

// MARK: - Life cycle

private extension HomeMainCoursesView {
    func addPageControl() {
        addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
    }

    func addCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate && UICollectionViewDataSource && UICollectionViewDelegateFlowLayout

extension HomeMainCoursesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.courses.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeMainCoursesCollectionViewCell = collectionView.dequeue(for: indexPath)
        cell.setup(data!.courses[indexPath.row], watchButtonTitle: data!.watchButtonTitle)
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
}
