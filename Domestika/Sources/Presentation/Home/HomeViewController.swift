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
        let homeView = HomeView()
        homeView.homeDelegate = self
        return homeView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        onViewDidLoad()
    }

    override func loadView() {
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
        navigationController?.isNavigationBarHidden = true
    }

    func onViewDidLoad() {
        navigationItem.backBarButtonItem = UIBarButtonItem()
        navigationItem.backBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back_arrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back_arrow")
    }

    func showMainCourses(_ courses: [HomeViewMainCourse]) {
        homeView.showMainCourses(courses)
    }

    func showPopularCourses(_ data: HomeViewPopularCourseData) {
        homeView.showPopularCourses(data)
    }
}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {
    func didSelectMainCourse(_ index: Int) {
        presenter.didSelectMainCourse(index)
    }

    func didSelectPopularCourse(_ index: Int) {
        presenter.didSelectPopularCourse(index)
    }
}
