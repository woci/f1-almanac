//
//  NameFormatter.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 15..
//

import Foundation

struct NameFormatter {
    private static var lock = DispatchQueue(label: "queue.serial.name.formatter")
    private static var formatter: PersonNameComponentsFormatter = {
        let formatter = PersonNameComponentsFormatter()
        formatter.style = .default
        return formatter
    }()

    func formattedName(forFirstname firstName: String, forLastName lastName: String) -> String {
        NameFormatter.lock.sync { () -> String in
            if NameFormatter.formatter.locale != Locale.current {
                NameFormatter.formatter.locale = Locale.current
            }

            var components = PersonNameComponents()
            components.givenName = firstName
            components.familyName = lastName
            return NameFormatter.formatter.string(for: components)!
        }
    }
}
