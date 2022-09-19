//
//  InputMeetingModels.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import Foundation

enum InputMeeting {
    enum InitForm {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}

struct Event {
    let name: String
    let startDate: Date
    let endDate: Date
    let creationDate: Date
    let info: String?
}
