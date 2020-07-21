//
//  HomeTopCollectionView.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit
import SnapKit

class HomeTopCollectionView: DOCollectionView {

    override public func setup() {
        delegate = self
        backgroundColor = .yellow
    }

    override public func addSubviews() {
    }

}

// MARK: - UICollectionViewDelegate && UICollectionViewDataSource

extension HomeTopCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
