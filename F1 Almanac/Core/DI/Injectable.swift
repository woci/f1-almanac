//
//  Injectable.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation

protocol Injectable {
    static var registeredName: String { get }
}

extension Injectable {
    static var registeredName: String {
        String(describing: self)
    }
}
