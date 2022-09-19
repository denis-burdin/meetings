//
//  DisplayMeetingAssembly.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit

enum DisplayMeetingAssembly {
    static func build() -> UIViewController {
        let presenter = DisplayMeetingPresenter()
        let worker = DisplayMeetingWorker()
        let interactor = DisplayMeetingInteractor(presenter: presenter, worker: worker)
        let router = DisplayMeetingRouter(dataStore: interactor)
        let viewController = DisplayMeetingViewController(interactor: interactor, router: router)

        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }
}
