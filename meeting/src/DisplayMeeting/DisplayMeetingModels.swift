//
//  DisplayMeetingModels.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import Foundation

enum DisplayMeeting {
    enum InitForm {
        struct Request {}
        struct Response {
            let eventInfo: [String]
        }
        struct ViewModel {
            let eventInfo: [String]
        }
    }
    enum MeetingCell {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let info: String
        }
    }
}
