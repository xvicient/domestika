//
//  HomeMainCoursesCollectionView.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeViewMainCourse {
    var imageURL: URL? { get }
    var title: String { get }
}

extension Course: HomeViewMainCourse {
    var imageURL: URL? {
        URL(string: thumbnailUrl)
    }
}

class HomeMainCoursesCollectionView: DOCollectionView {

    var courses = [HomeViewMainCourse]() {
        didSet {
            reloadData()
        }
    }

    override public func setup() {
        register(HomeMainCoursesCollectionViewCell.self)
        delegate = self
        dataSource = self
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
    }

    override public func addSubviews() {
    }

}

// MARK: - UICollectionViewDelegate && UICollectionViewDataSource && UICollectionViewDelegateFlowLayout

extension HomeMainCoursesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
}
