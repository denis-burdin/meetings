//
//  InputMeetingWorker.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit
import CoreData

final class InputMeetingWorker: InputMeetingWorkerLogic {    
    func createNewItem(_ item: Event) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(
            forEntityName: "Events",
            in: managedContext
        ) else {
            return
        }
        
        let event = NSManagedObject(
            entity: entity,
            insertInto: managedContext
        )
        event.setValue(item.name, forKeyPath: "name")
        event.setValue(item.startDate, forKeyPath: "startDate")
        event.setValue(item.endDate, forKeyPath: "endDate")
        event.setValue(item.info, forKeyPath: "info")
        event.setValue(item.creationDate, forKeyPath: "creationDate")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
