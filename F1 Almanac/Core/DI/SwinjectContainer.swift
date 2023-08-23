//
//  SwinjectContainer.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import Swinject

class SwinjectContainer {
    static let shared = SwinjectContainer()
    lazy var container = Container()
    private init() {}
}
