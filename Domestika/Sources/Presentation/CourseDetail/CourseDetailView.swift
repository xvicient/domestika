//
//  CourseDetailView.swift
//  Domestika
//
//  Created by Xavier on 23/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

struct CourseDetailViewData: Equatable {
    let imageUrl: URL?
    let videoUrl: URL?
    let title: String
    let description: String
    let teacher: String
    let teacherAvatarUrl: URL?
    let location: String
    let data: [CourseDetailItemViewData]
}

final class CourseDetailView: DOView {

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
        return view
    }()

    private lazy var videoView: CourseDetailVideoView = {
        CourseDetailVideoView()
    }()

    private lazy var informationView: CourseDetailInformationView = {
        CourseDetailInformationView()
    }()

    override func setup() {
        backgroundColor = .white
    }

    override func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(videoView)
        stackView.addArrangedSubview(informationView)
    }

    override func addConstraints() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(self)
            $0.height.equalTo(self).priority(250)
        }

        stackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }

        videoView.snp.makeConstraints {
            $0.height.equalTo(225)
        }
    }

    func show(_ data: CourseDetailViewData) {
        videoView.show(data)
        informationView.show(data)
    }
}
