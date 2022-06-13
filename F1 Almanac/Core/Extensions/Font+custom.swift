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
        case .subtitle, .mediumTitle, .mediumHeader, .buttonTitle, .smallBody, .tabBarTitleUnselected: return Font.custom(UIFont.F1Font.medium.fontName(), size: pointSize)
        case .largeBody, .mediumBody, .body: return Font.custom(UIFont.F1Font.regular.fontName(), size: pointSize)
        }
    }
}

@objc public enum TextStyle: Int, CaseIterable {
    public struct LineHeightRatio {
        public static var min: CGFloat = 1.2
        public static var max: CGFloat = 1.45
    }

    case pageTitle // wide 20
    case largeSubtitle // wide 18
    case title // wide 16
    case subtitle // medium 16
    case largeBody // regular 16
    case mediumTitle // medium 15
    case mediumBody // regular 15
    case buttonTitle // medium 14
    case mediumHeader // medium 14
    case body // regular 14
    case tabBarTitleSelected // medium 11
    case tabBarTitleUnselected // regular 11
    case smallBody // medium 10

    public var pointSize: CGFloat {
        switch self {
        case .pageTitle: return 20
        case .largeSubtitle: return 18
        case .title, .subtitle, .largeBody: return 16
        case .mediumTitle, .mediumBody: return 15
        case .mediumHeader, .buttonTitle, .body: return 14
        case .tabBarTitleSelected, .tabBarTitleUnselected: return 11
        case .smallBody: return 10
        }
    }

    public var font: UIFont.F1Font {
        switch self {
        case .pageTitle, .largeSubtitle, .title: return .wide
        case .subtitle, .mediumTitle, .mediumHeader, .buttonTitle, .smallBody, .tabBarTitleSelected: return .medium
        case .largeBody, .mediumBody, .body, .tabBarTitleUnselected: return .regular
        }
    }

    public var characterSpace: CGFloat {
        switch self {
        case .pageTitle, .largeSubtitle, .mediumTitle: return 1.0
        case .title, .subtitle, .largeBody, .mediumBody, .mediumHeader, .body: return 0.3
        case .buttonTitle: return 2.0
        case .smallBody, .tabBarTitleSelected, .tabBarTitleUnselected: return 0.9
        }
    }

    public var lineHeight: CGFloat {
        var lineHeightRatio: CGFloat = LineHeightRatio.min

        switch self {
        case .pageTitle: lineHeightRatio = LineHeightRatio.min
        case .largeSubtitle: lineHeightRatio = 1.26
        case .title, .subtitle, .largeBody:  lineHeightRatio = 1.31
        case .mediumTitle, .mediumBody: lineHeightRatio = 1.34
        case .mediumHeader, .body: lineHeightRatio = 1.367
        case .buttonTitle: lineHeightRatio = 1
        case .smallBody, .tabBarTitleSelected, .tabBarTitleUnselected: lineHeightRatio = LineHeightRatio.max
        }

        return self.pointSize * lineHeightRatio
    }

    public func height(forLines lines: Int) -> CGFloat {
        lineHeight * CGFloat(lines)
    }
}
