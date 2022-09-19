//
//  InputMeetingPresenter.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import Foundation

final class InputMeetingPresenter: InputMeetingPresentationLogic {
    weak var view: InputMeetingDisplayLogic?

    func presentInitForm(_ response: InputMeeting.InitForm.Response) {
        view?.displayInitForm(InputMeeting.InitForm.ViewModel())
    }
}
