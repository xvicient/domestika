//
//  HomeViewController.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import SnapKit
import UIKit

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol!

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
        view.spacing = 40
        return view
    }()

    private lazy var mainCoursesView: HomeMainCoursesView = {
        let view = HomeMainCoursesView()
        view.coursesDelegate = self
        return view
    }()

    private lazy var popularCoursesView: HomePopularCoursesView = {
        let view = HomePopularCoursesView()
        view.coursesDelegate = self
        return view
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

// MARK: - Life cycle

extension HomeViewController {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(mainCoursesView)
        stackView.addArrangedSubview(popularCoursesView)
    }

    func addConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(view)
            $0.height.equalTo(view).priority(250)
        }

        stackView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(contentView)
            $0.bottom.equalTo(contentView).inset(40)
        }

        mainCoursesView.snp.makeConstraints {
            $0.height.equalTo(450)
        }

        popularCoursesView.snp.makeConstraints {
            $0.height.equalTo(325)
        }
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
        addSubviews()
        addConstraints()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem()
        navigationItem.backBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back_arrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back_arrow")
    }

    func showMainCourses(_ courses: [HomeViewMainCourse]) {
        mainCoursesView.courses = courses
    }

    func showPopularCourses(_ data: HomeViewPopularCourseData) {
        popularCoursesView.data = data
    }
}

// MARK: - HomeMainCoursesViewDelegate && HomePopularCoursesViewDelegate

extension HomeViewController: HomeMainCoursesViewDelegate, HomePopularCoursesViewDelegate {
    func didSelectMainCourse(_ index: Int) {
        presenter.didSelectMainCourse(index)
    }

    func didSelectPopularCourse(_ index: Int) {
        presenter.didSelectPopularCourse(index)
    }
}
