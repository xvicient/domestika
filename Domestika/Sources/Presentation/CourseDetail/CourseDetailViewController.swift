//
//  CourseDetailViewController.swift
//  Domestika
//
//  Created by Xavier on 22/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit

final class CourseDetailViewController: UIViewController {
    var presenter: CourseDetailPresenterProtocol!

    private lazy var courseDetailView: CourseDetailView = {
        let courseDetailView = CourseDetailView()
        return courseDetailView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        onViewDidLoad()
    }

    override func loadView() {
        super.loadView()
        view = courseDetailView
    }
}

// MARK: - CourseDetailViewProtocol

extension CourseDetailViewController: CourseDetailViewProtocol {
    func render(state: CourseDetailViewState) {
        switch state {
        case let .show(data):
            show(data)
        }
    }
}

// MARK: - Private

private extension CourseDetailViewController {
    func onViewWillAppear() {
        navigationController?.isNavigationBarHidden = false
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share"), style: .plain, target: self, action: nil)
        shareButton.tintColor = .black
        navigationItem.rightBarButtonItem  = shareButton
    }

    func onViewDidLoad() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
    }

    func show(_ data: CourseDetailViewData) {
        courseDetailView.show(data)
    }
}
