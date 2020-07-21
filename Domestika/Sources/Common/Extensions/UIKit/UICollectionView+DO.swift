//
//  UICollectionView+DO.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

// MARK: - Register Cell Nibs

extension UICollectionView {
    func register(_ cellClass: Swift.AnyClass) {
        let identifier = String(describing: cellClass.self)
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
}

// MARK: - Dequeuing

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let id = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! T
    }
}
