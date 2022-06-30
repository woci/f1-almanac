//
//  Font+custom.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 07..
//

import Foundation
import SwiftUI

extension Text {
    @ViewBuilder func `textStyle`(_ style: TextStyle) -> some View {
        self.tracking(style.characterSpace)
            .font(style.swiftUIfont)
            .lineSpacing(style.lineHeight - style.pointSize)
    }
}
extension View {
    /// Attach this to any Xcode Preview's view to have custom fonts displayed
    /// Note: Not needed for the actual app
    public func loadCustomFonts() -> some View {
        UIFont.registerCustomFonts()
        return self
    }
}

extension TextStyle {
    public var swiftUIfont: Font {
        switch self {
        case .pageTitle, .largeSubtitle, .title, .tabBarTitleSelected: return Font.custom(UIFont.F1Font.wide.fontName(), size: pointSize)
        case .subtitle, .mediumTitle, .mediumHeader, .buttonTitle: return Font.custom(UIFont.F1Font.medium.fontName(), size: pointSize)
        case .largeBody, .mediumBody, .body, .smallBody, .tinyBody, .tabBarTitleUnselected: return Font.custom(UIFont.F1Font.regular.fontName(), size: pointSize)
        }
    }
}

@objc public enum TextStyle: Int, CaseIterable {
    public struct LineHeightRatio {
        public static var min: CGFloat = 1.2
        public static var max: CGFloat = 1.45
    }

    case pageTitle // wide 19
    case largeSubtitle // wide 17
    case title // wide 15
    case subtitle // medium 15
    case largeBody // regular 15
    case mediumTitle // medium 14
    case mediumBody // regular 14
    case buttonTitle // medium 13
    case mediumHeader // medium 13
    case body // regular 13
    case smallBody // regular 11
    case tabBarTitleSelected // medium 10
    case tabBarTitleUnselected // regular 10
    case tinyBody // regular 9

    public var pointSize: CGFloat {
        switch self {
        case .pageTitle: return 19
        case .largeSubtitle: return 17
        case .title, .subtitle, .largeBody: return 15
        case .mediumTitle, .mediumBody: return 14
        case .mediumHeader, .buttonTitle, .body: return 13
        case .smallBody: return 11
        case .tabBarTitleSelected, .tabBarTitleUnselected: return 10
        case .tinyBody: return 9
        }
    }

    public var font: UIFont.F1Font {
        switch self {
        case .pageTitle, .largeSubtitle, .title: return .wide
        case .subtitle, .mediumTitle, .mediumHeader, .buttonTitle, .tabBarTitleSelected: return .medium
        case .largeBody, .mediumBody, .body, .tinyBody, .tabBarTitleUnselected, .smallBody: return .regular
        }
    }

    public var characterSpace: CGFloat {
        switch self {
        case .pageTitle, .largeSubtitle, .mediumTitle: return 1.0
        case .title, .subtitle, .largeBody, .mediumBody, .mediumHeader, .body, .smallBody: return 0.3
        case .buttonTitle: return 2.0
        case .tinyBody, .tabBarTitleSelected, .tabBarTitleUnselected: return 0.9
        }
    }

    public var lineHeight: CGFloat {
        var lineHeightRatio: CGFloat = LineHeightRatio.min

        switch self {
        case .buttonTitle: lineHeightRatio = 1
        case .pageTitle: lineHeightRatio = LineHeightRatio.min
        case .largeSubtitle: lineHeightRatio = 1.26
        case .title, .subtitle, .largeBody:  lineHeightRatio = 1.31
        case .mediumTitle, .mediumBody: lineHeightRatio = 1.34
        case .mediumHeader, .body: lineHeightRatio = 1.367
        case .smallBody: lineHeightRatio = 1.4
        case .tinyBody, .tabBarTitleSelected, .tabBarTitleUnselected: lineHeightRatio = LineHeightRatio.max
        }

        return self.pointSize * lineHeightRatio
    }

    public func height(forLines lines: Int) -> CGFloat {
        lineHeight * CGFloat(lines)
    }
}
