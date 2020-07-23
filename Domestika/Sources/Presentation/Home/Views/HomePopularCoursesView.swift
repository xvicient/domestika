//
//  HomePopularCoursesView.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit
import SnapKit

struct HomeViewPopularCourseData: Equatable {
    let courses: [HomeViewPopularCourse]
    let popularCourseTitle: String
}

struct HomeViewPopularCourse: Equatable {
    let imageURL: URL?
    let title: String
    let teacher: String
    let watchCourseTitle: String
}

protocol HomePopularCoursesViewDelegate: class {
    func didSelectPopularCourse(_ index: Int)
}

class HomePopularCoursesView: DOView {

    weak var coursesDelegate: HomePopularCoursesViewDelegate?

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        return titleLabel
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.register(HomePopularCoursesCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    var data: HomeViewPopularCourseData? {
        didSet {
            titleLabel.text = data?.popularCourseTitle
            collectionView.reloadData()
        }
    }

    override func setup() {
        backgroundColor = .clear
    }

    override func addSubviews() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }

    override func addConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

}

// MARK: - Private

private extension HomePopularCoursesView {
    var collectionViewLayout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout(section: layoutSecion)
    }

    var layoutSecion: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.80),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 10.0)
        
        return section
    }
}

// MARK: - UICollectionViewDelegate && UICollectionViewDataSource && UICollectionViewDelegateFlowLayout

extension HomePopularCoursesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.courses.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomePopularCoursesCollectionViewCell = collectionView.dequeue(for: indexPath)
        cell.setup(data!.courses[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coursesDelegate?.didSelectPopularCourse(indexPath.row)
    }
}
