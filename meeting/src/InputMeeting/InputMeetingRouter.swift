//
//  InputMeetingRouter.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit

final class InputMeetingRouter: InputMeetingRoutingLogic {
    weak var viewController: UIViewController?
    private let dataStore: InputMeetingDataStore

    init(dataStore: InputMeetingDataStore) {
        self.dataStore = dataStore
    }
}

private extension InputMeetingRouter {}
