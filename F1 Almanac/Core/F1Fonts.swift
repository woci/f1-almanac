//
//  F1Fonts.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 07..
//

import Foundation
import UIKit

extension Bundle {
    public static func resourceBundle(forBundleClassType classType: AnyClass, inBundleWithName bundleName: String) -> Bundle? {
        let frameworkBundle = Bundle(for: classType.self)
        guard let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent(bundleName) else {
            return Optional.none
        }

        return Bundle(url: bundleURL)
    }
}

private class FontBundleClass {}

private class F1FontCache {
    lazy private var fonts = [UIFont.F1Font: [CGFloat: UIFont]]()

    private init() {}

    fileprivate static let sharedCache = F1FontCache()

    fileprivate func cachedFont(font: UIFont.F1Font, withSize size: CGFloat) -> UIFont? {
        return fonts[font]?[size]
    }

    fileprivate func storeFont(font: UIFont, fontFace: UIFont.F1Font, size: CGFloat) {
        if fonts[fontFace] != Optional.none {
            fonts[fontFace]![size] = font
        } else {
            let fontValue = [size: font]
            fonts[fontFace] = fontValue
        }
    }
}

extension UIFont {
    public enum F1Font: CaseIterable {
        case regular
        case medium
        case wide

        fileprivate func fileName() -> String {
            switch self {
            case .regular:
                return "Formula1-Regular.otf"
            case .medium:
                return "Formula1-Bold.otf"
            case .wide:
                return "Formula1-Wide.otf"
            }
        }

        public func fontName() -> String {
            switch self {
            case .regular:
                return "Formula1-Display-Regular"
            case .medium:
                return "Formula1-Display-Bold"
            case .wide:
                return "Formula1-Display-Wide"
            }
        }
    }

    public enum FontError: Error {
        case bundleNotFound
    }

    private static var bundle: Bundle {
        return Bundle(for: FontBundleClass.self)
    }

    public static func font(for fontFace: F1Font, size: CGFloat) -> UIFont? {
        if let cachedFont = F1FontCache.sharedCache.cachedFont(font: fontFace, withSize: size) {
            return cachedFont
        }

        if let fileURL = fontURL(fontFace: fontFace) {
            if let cgFont = UIFont.CGFontWithURL(url: fileURL) {
                let fontName = cgFont.postScriptName! as String
                let font = UIFont(name: fontName, size: size)!
                F1FontCache.sharedCache.storeFont(font: font, fontFace: fontFace, size: size)
                return font
            }
        }

        return Optional.none
    }

    private static func fontURL(fontFace: F1Font) -> URL? {
        guard let bundleURL = UIFont.bundle.resourceURL else {
            return Optional.none
        }

        do {
            let fontsDir = try FileManager.default.contentsOfDirectory(at: bundleURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)

            return fontsDir.first(where: { (url: URL) -> Bool in
                url.lastPathComponent == fontFace.fileName()})
        } catch {
            print("BurberryFont Error (unable to load font directory): \(error)")
            return Optional.none
        }
    }

    private static func CGFontWithURL(url: URL) -> CGFont? {
        do {
            let fontBinary = try Data(contentsOf: url)

            let error: UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
            if let dataProvider = CGDataProvider(data: fontBinary as CFData), let font = CGFont(dataProvider) {
                CTFontManagerRegisterGraphicsFont(font, error)

                if error != Optional.none {
                    let errorDescription = CFErrorCopyDescription((error as! CFError))
                    print("BurberryFont Error (failed to register font): \(String(describing: errorDescription))")
                } else {
                    return font
                }
            }
        } catch {
            print("BurberryFont Error (unable to load font from url): \(error)")
        }

        return Optional.none
    }


    public static func registerCustomFonts() {
        for font in F1Font.allCases {
            guard let url = UIFont.fontURL(fontFace: font) else { return }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}

extension Bundle {
    private class CurrentBundleFinder {}

    /// This is used to allow you to use resources from DesignSystem in other Swift Package previews.
    /// Inspiration from here: https://developer.apple.com/forums/thread/664295
    public static var designSystem: Bundle = {
        // The name of your local package bundle. This may change on every different version of Xcode.
        // It used to be "LocalPackages_<ModuleName>" for iOS. To find out what it is, print out  the path for
        // Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent()
        // and then look for what bundle is named in there.
        let bundleNameIOS = "F1-Almanac"
        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: CurrentBundleFinder.self).resourceURL,
            // For command-line tools.
            Bundle.main.bundleURL,
            // Bundle should be present here when running previews from a different package
            // (this is the path to "…/Debug-iphonesimulator/").
            Bundle(for: CurrentBundleFinder.self)
                .resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent(),
            Bundle(for: CurrentBundleFinder.self)
                .resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent(),
        ]

        for candidate in candidates {
            let bundlePathiOS = candidate?.appendingPathComponent(bundleNameIOS + ".bundle")
            if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("Can't find designSystem custom bundle. See Bundle+Extensions.swift")
    }()
}

