//
//  InputMeetingProtocols.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

protocol InputMeetingDataStore {}

protocol InputMeetingBusinessLogic {
    func requestInitForm(_ request: InputMeeting.InitForm.Request)
    func saveRecord(_ event: Event)
}

protocol InputMeetingWorkerLogic {
    func createNewItem(_ item: Event)
}

protocol InputMeetingPresentationLogic {
    func presentInitForm(_ response: InputMeeting.InitForm.Response)
}

protocol InputMeetingDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: InputMeeting.InitForm.ViewModel)
}

protocol InputMeetingRoutingLogic {}
