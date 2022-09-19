//
//  DisplayMeetingInteractor.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit
import CoreData
import Foundation

final class DisplayMeetingInteractor: DisplayMeetingBusinessLogic, DisplayMeetingDataStore {
    private let presenter: DisplayMeetingPresentationLogic
    private let worker: DisplayMeetingWorkerLogic
    
    init(
        presenter: DisplayMeetingPresentationLogic,
        worker: DisplayMeetingWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        // Add Observer
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(managedObjectContextObjectsDidChange),
            name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
            object: managedContext
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func requestInitForm(_ request: DisplayMeeting.InitForm.Request) {
        let emptyResponse = DisplayMeeting.InitForm.Response(
            eventInfo: ["no_events".localized]
        )
        DispatchQueue.main.async {
            self.presenter.presentInitForm(emptyResponse)
        }
    }
    
    func requestEvents(_ request: DisplayMeeting.InitForm.Request) {
        worker.requestEvents { [weak self] result in
            guard let self = self else { return }
            var eventInfo: [String] = [String]()
            let sortedEvents: [Event] = result.sorted {
                $0.creationDate < $1.creationDate
            }
            for event in sortedEvents {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm E, d MMM y"
                let startDate: String = formatter.string(from: event.startDate)
                let endDate: String = formatter.string(from: event.endDate)
                let text: String = "event_description".localized(
                    arguments: event.name, startDate, endDate, event.info ?? ""
                )
                eventInfo.append(text)
            }
            let response = DisplayMeeting.InitForm.Response(
                eventInfo: eventInfo
            )
            DispatchQueue.main.async {
                self.presenter.presentInitForm(response)
            }
        }
    }
    
    @objc private func managedObjectContextObjectsDidChange() {
        requestEvents(DisplayMeeting.InitForm.Request())
    }
}
