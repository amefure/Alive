//
//  SettingViewModel.swift
//  Alive
//
//  Created by t&a on 2023/11/24.
//

import UIKit

class SettingViewModel {
    
    private let shareInfoManager = ShareInfoManager()
    
    private let appUrlStr = L10n.appUrl
    private let shareText = L10n.settingRecommendShareText

    // App Store URL
    private var appUrl: URL {
        if let encurl = appUrlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let url = URL(string: encurl) {
                return url
            }
        }
        return URL(string: "https://tech.amefure.com/")!
    }

    // App Store Review URL
    public var reviewUrl: URL {
        let reviewUrlString = appUrlStr + L10n.settingReviewUrlQuery
        if let encurl = reviewUrlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let url = URL(string: encurl) {
                return url
            }
        }
        return appUrl
    }

    // 利用規約&プライバシーポリシーURL
    public var termsUrl: URL {
        if let url =  URL(string: L10n.settingTermsOfServiceUrl) {
            return url
        }
        return appUrl
    }

    // アプリのシェアロジック
    public func shareApp() {
        shareInfoManager.shareApp(text: shareText, url: appUrl)
    }
}
