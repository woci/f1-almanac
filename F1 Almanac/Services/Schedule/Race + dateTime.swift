//
//  Race + dateTime.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation

extension Schedule.Season.Race {
    var dateTime: Date {
        CustomDateFormatter().dateTime(forDate: date, forTime: time)
    }
}

extension Session {
    var dateTime: Date {
        CustomDateFormatter().dateTime(forDate: date, forTime: time)
    }
}
