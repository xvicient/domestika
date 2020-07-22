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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

// MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func render(state: HomeViewState) {
        switch state {
        case let .showMainCourses(data):
            showMainCourses(data)
        case let .showPopularCourses(data):
            showPopularCourses(data)
        }
    }
}

// MARK: - Private

private extension HomeViewController {
    func onViewWillAppear() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func showMainCourses(_ courses: [HomeViewMainCourse]) {
        homeView.showMainCourses(courses)
    }

    func showPopularCourses(_ data: HomeViewPopularCourseData) {
        homeView.showPopularCourses(data)
    }
}
