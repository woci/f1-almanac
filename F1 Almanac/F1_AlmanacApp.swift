//
//  F1_AlmanacApp.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import SwiftUI
import UIKit

@main
struct F1_AlmanacApp: App {
    init() {
        let appearance = UINavigationBarAppearance()

        appearance.largeTitleTextAttributes = [
            .font: UIFont.font(for: TextStyle.pageTitle.font, size: 16)!,
        ]
        appearance.titleTextAttributes = [
            .font: UIFont.font(for: TextStyle.title.font, size: 12)!,
        ]

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        SwinjectContainer.shared.register()
    }

    var body: some Scene {
        WindowGroup {
            AppView().loadCustomFonts()
        }
    }
}


// no changes in your AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //        Create a UINavigationBarAppearance object


        return true
    }
}
