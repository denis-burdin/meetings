//
//  InputMeetingAssembly.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit

enum InputMeetingAssembly {
    static func build() -> UIViewController {
        let presenter = InputMeetingPresenter()
        let worker = InputMeetingWorker()
        let interactor = InputMeetingInteractor(presenter: presenter, worker: worker)
        let router = InputMeetingRouter(dataStore: interactor)
        let viewController = InputMeetingViewController(interactor: interactor, router: router)

        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }
}
