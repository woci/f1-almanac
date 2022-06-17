//
//  DateFormatter.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 13..
//

import Foundation

struct CustomDateFormatter {

    enum DateFormat: String {
        case midWithTime = ""
    }

    private static var lock = DispatchQueue(label: "queue.serial.formatter")
    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.locale = Locale.current
        return formatter
    }()

    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter
    }()

    private func unsafeFormattedDate(for date: Date, dateStyle: DateFormatter.Style = .full, timeStyle: DateFormatter.Style = .none) -> String {
        if CustomDateFormatter.formatter.locale != Locale.current {
            CustomDateFormatter.formatter.locale = Locale.current
        }

        CustomDateFormatter.formatter.dateStyle = dateStyle
        CustomDateFormatter.formatter.timeStyle = timeStyle

        return CustomDateFormatter.formatter.string(for: date)!
    }

    private func unsafeDateTime(forDate date: String, forTime time: String) -> Date {
        let unformattedDateString = "\(date)T\(time)"
        CustomDateFormatter.formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        CustomDateFormatter.formatter.locale = Locale(identifier: "en_US_POSIX")
        return CustomDateFormatter.formatter.date(from: unformattedDateString)!
    }

    func formattedDate(for date: Date, dateStyle: DateFormatter.Style = .full, timeStyle: DateFormatter.Style = .none) -> String {
        CustomDateFormatter.lock.sync { () -> String in
            return self.unsafeFormattedDate(for: date, dateStyle: dateStyle, timeStyle: timeStyle)
        }
    }

    func formattedDate(forDate date: String, forTime time: String, dateStyle: DateFormatter.Style = .full, timeStyle: DateFormatter.Style = .none) -> String {
        CustomDateFormatter.lock.sync { () -> String in
            let date = self.unsafeDateTime(forDate: date, forTime: time)
            return self.unsafeFormattedDate(for: date, dateStyle: dateStyle, timeStyle: timeStyle)
        }
    }

    func formattedDate(forDate date: String, forTime time: String, dateFormat: String) -> String {
        CustomDateFormatter.lock.sync { () -> String in
            if CustomDateFormatter.formatter.locale != Locale.current {
                CustomDateFormatter.formatter.locale = Locale.current
            }
            CustomDateFormatter.formatter.dateFormat = dateFormat

            return CustomDateFormatter.formatter.string(for: date)!
        }
    }

    func dateTime(forDate date: String, forTime time: String) -> Date {
        CustomDateFormatter.lock.sync { () -> Date in
            return unsafeDateTime(forDate: date, forTime: time)
        }
    }

    func time(forTime timeString: String) -> TimeInterval {
        CustomDateFormatter.lock.sync { () -> TimeInterval in
            let timeMultipiler = [1.0,60.0,3600.0] //seconds for unit
            var time = 0.0
            var timeComponents = timeString.components(separatedBy: ":")
            if timeComponents.count > timeMultipiler.count{
                return 0
            }

            timeComponents.reverse()

            for index in 0..<timeComponents.count{ guard let timeComponent = Double(timeComponents[index]) else { return 0}
                time += timeComponent * timeMultipiler[index] }

            guard let number =  CustomDateFormatter.numberFormatter.string(from: NSNumber(value: time)) else { fatalError("Can not get number") }

            return TimeInterval(number)!
        }
    }
}
