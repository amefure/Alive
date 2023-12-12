//
//  AliveApp.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI
import FirebaseCore
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}

@main
struct AliveApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - Environment
    @ObservedObject private var rootEnvironment = RootEnvironment()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if UserDefaultsRepositoryViewModel.sheard.isInitialBoot {
                    /// 一度でもアプリを起動していれば
                    RootView()
                        .environmentObject(rootEnvironment)
                } else {
                    /// アプリ初回起動時
                    SplashView()
                        .environmentObject(rootEnvironment)
                }
            }.dialog(isPresented: $rootEnvironment.isPresentError, title: rootEnvironment.errorTitle, message: rootEnvironment.errorMessage)
        }
    }
}
