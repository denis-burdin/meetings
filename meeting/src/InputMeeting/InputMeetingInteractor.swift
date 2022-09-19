//
//  InputMeetingInteractor.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import Foundation

final class InputMeetingInteractor: InputMeetingBusinessLogic, InputMeetingDataStore {
    private let presenter: InputMeetingPresentationLogic
    private let worker: InputMeetingWorkerLogic

    init(
        presenter: InputMeetingPresentationLogic,
        worker: InputMeetingWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func requestInitForm(_ request: InputMeeting.InitForm.Request) {
        DispatchQueue.main.async {
            self.presenter.presentInitForm(InputMeeting.InitForm.Response())
        }
    }
    
    func saveRecord(_ event: Event) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.worker.createNewItem(event)
        }
    }
}
