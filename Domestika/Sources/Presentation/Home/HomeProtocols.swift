//
//  HomeProtocols.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient All rights reserved.
//

import UIKit

// MARK: - Builder

// sourcery: AutoMockable
protocol HomeBuilderProtocol {
    func buildModule() -> UIViewController
}

// MARK: - Router

// sourcery: AutoMockable
protocol HomeRouterProtocol {
    func showCourse(_ course: Course)
    func show(_ message: String, okTitle: String)
}

// MARK: - Presenter

// sourcery: AutoMockable
protocol HomePresenterProtocol {
    func viewDidLoad()
    func didTapCourse(_ index: Int, section: HomeViewCourseSection)
}

// MARK: - Interactor

// sourcery: AutoMockable
protocol HomeInteractorProtocol {
    func courses(completion: @escaping (Result<[Course], APIError>) -> Void)
}

// MARK: - View

enum HomeViewState: Equatable {
    case showMainCourses(_ courses: [HomeViewMainCourse])
    case showPopularCourses(_ data: HomeViewPopularCourseData)
}

// sourcery: AutoMockable
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol! { get set }
    func render(state: HomeViewState)
}
