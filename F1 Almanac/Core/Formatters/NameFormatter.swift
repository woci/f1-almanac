//
//  NameFormatter.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 15..
//

import Foundation

struct NameFormatter {
    enum Style: Int {
        case `default` = 0
        case short = 1
        case medium = 2
        case long = 3
        case abbreviated = 4
        case firstWordAbbreviated = 5

        func toPersonNameComponentsFormatterStyle() -> PersonNameComponentsFormatter.Style {
            switch self {
            case .default, .firstWordAbbreviated:
                return .default
            case .short:
                return .short
            case .medium:
                return .medium
            case .long:
                return .long
            case .abbreviated:
                return .abbreviated
            }
        }
    }
    private static var lock = DispatchQueue(label: "queue.serial.name.formatter")
    private static var formatter: PersonNameComponentsFormatter = {
        let formatter = PersonNameComponentsFormatter()
        formatter.style = .default
        return formatter
    }()

    func formattedName(forFirstname firstName: String, forLastName lastName: String, style: Style = .default) -> String {
        NameFormatter.lock.sync { () -> String in
            if NameFormatter.formatter.locale != Locale.current {
                NameFormatter.formatter.locale = Locale.current
            }

            var components = PersonNameComponents()
            components.givenName = firstName
            components.familyName = lastName
            NameFormatter.formatter.style = style.toPersonNameComponentsFormatterStyle()
            var formattedName = NameFormatter.formatter.string(for: components)!

            if style == .firstWordAbbreviated {
                formattedName = formateToFirstWordAbbreviated(preFormattedName: formattedName)
            }

            return formattedName
        }
    }

    private func formateToFirstWordAbbreviated(preFormattedName: String) -> String {
        let nameComponents = preFormattedName.components(separatedBy: " ")
        return nameComponents.reduce("\(String(describing: nameComponents.first?.first)).") { partialResult, nextComponent in
            partialResult + " " + nextComponent
        }
    }

}
