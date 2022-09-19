//
//  DisplayMeetingRouter.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit

final class DisplayMeetingRouter: DisplayMeetingRoutingLogic {
    weak var viewController: UIViewController?
    private let dataStore: DisplayMeetingDataStore

    init(dataStore: DisplayMeetingDataStore) {
        self.dataStore = dataStore
    }
}

private extension DisplayMeetingRouter {}
