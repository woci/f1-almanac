//
//  CountryFlag.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation

protocol CountryFlagService {
    func url(ofFlagForCountryCode countryCode: String) -> URL
}

struct ConcreteCountryFlagService: CountryFlagService {
    func url(ofFlagForCountryCode countryCode: String) -> URL {
        URL(string: "https://countryflagsapi.com/png/\(countryCode)")!
    }
}
