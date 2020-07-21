//
//  HomeViewController.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol!

    private lazy var homeView: HomeView = {
        HomeView()
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    override public func loadView() {
        super.loadView()
        view = homeView
    }
}

// MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func render(state: HomeViewState) {
        switch state {
        case let .showTopCourses(courses):
            showTopCourses(courses)
        }
    }
}

// MARK: - Private

private extension HomeViewController {
    func onViewWillAppear() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func showTopCourses(_ courses: [HomeViewMainCourse]) {
        homeView.showTopCourses(courses)
    }
}
