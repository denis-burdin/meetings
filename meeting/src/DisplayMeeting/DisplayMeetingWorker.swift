//
//  DisplayMeetingWorker.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit
import CoreData

final class DisplayMeetingWorker: DisplayMeetingWorkerLogic {
    func requestEvents(_ completion: ([Event]) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Events")
        
        do {
            let events = try managedContext.fetch(fetchRequest)
            var result: [Event] = [Event]()
            for item in events {
                if let name = item.value(forKeyPath: "name") as? String,
                   let startDate = item.value(forKeyPath: "startDate") as? Date,
                   let endDate = item.value(forKeyPath: "endDate") as? Date,
                   let creationDate = item.value(forKeyPath: "creationDate") as? Date,
                   let info = item.value(forKeyPath: "info") as? String {
                    let event = Event(
                        name: name,
                        startDate: startDate,
                        endDate: endDate,
                        creationDate: creationDate,
                        info: info
                    )
                    result.append(event)                    
                }
            }
            completion(result)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
