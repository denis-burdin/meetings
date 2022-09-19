//
//  DisplayMeetingPresenter.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import Foundation

final class DisplayMeetingPresenter: DisplayMeetingPresentationLogic {
    weak var view: DisplayMeetingDisplayLogic?
    
    func presentInitForm(_ response: DisplayMeeting.InitForm.Response) {
        let viewModel = DisplayMeeting.InitForm.ViewModel(
            eventInfo: response.eventInfo
        )
        view?.displayInitForm(viewModel)
    }
}
