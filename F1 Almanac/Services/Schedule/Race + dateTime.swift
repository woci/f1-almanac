//
//  Race + dateTime.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation

extension Race {
    var dateTime: Date {
        Date.dateTime(forDate: date, forTime: time)
    }
}

extension Session {
    var dateTime: Date {
        Date.dateTime(forDate: date, forTime: time)
    }
}


extension Date {
    static func dateTime(forDate date: String, forTime time: String) -> Date {
        let isoDate = "\(date)T\(time)"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        return date
    }
}
