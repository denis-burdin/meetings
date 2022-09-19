//
//  DisplayMeetingProtocols.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

protocol DisplayMeetingDataStore {}

protocol DisplayMeetingBusinessLogic {
    func requestInitForm(_ request: DisplayMeeting.InitForm.Request)
    func requestEvents(_ request: DisplayMeeting.InitForm.Request)
}

protocol DisplayMeetingWorkerLogic {
    func requestEvents(_ completion: ([Event]) -> Void)
}

protocol DisplayMeetingPresentationLogic {
    func presentInitForm(_ response: DisplayMeeting.InitForm.Response)
}

protocol DisplayMeetingDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: DisplayMeeting.InitForm.ViewModel)
}

protocol DisplayMeetingRoutingLogic {}
