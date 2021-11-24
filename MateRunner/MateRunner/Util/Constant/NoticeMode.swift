//
//  NoticeMode.swift
//  MateRunner
//
//  Created by 이유진 on 2021/11/24.
//

import Foundation

enum NoticeMode: String {
    case invite = "invite"
    case requestMate = "requestMate"
    
    func text() -> String {
        return self.rawValue
    }
}
