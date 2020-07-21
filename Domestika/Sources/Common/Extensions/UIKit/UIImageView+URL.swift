//
//  UIImageView+URL.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    func load(url: URL, _ completion: ((UIImage?, ImagePipeline.Error?) -> Void)? = nil) {
        Nuke.loadImage(with: url, options: ImageLoadingOptions(), into: self) { result in
            switch result {
            case let .success(response): completion?(response.image, nil)
            case let .failure(error): completion?(nil, error)
            }
        }
    }
}
