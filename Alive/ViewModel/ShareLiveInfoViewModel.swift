//
//  ShareLiveInfoViewModel.swift
//  Alive
//
//  Created by t&a on 2023/11/28.
//

import UIKit

class ShareLiveInfoViewModel: ObservableObject {
    
    static let shared = ShareLiveInfoViewModel()
    
    private let shareInfoManager = ShareInfoManager()
    
    private var lives: [Live] = []
    
    @Published var text: String = ""
    @Published var switchFlag: Bool = false
    
    public func convertLiveInfoString() {
        let df = DateFormatManager()
        text = ""
        for live in lives.sorted(by: { $0.date > $1.date}) {
            if switchFlag {
                text = text + df.getStringSlash(date: live.date) + " " + live.name + "\n"
            } else {
                text = text + df.getStringSlash(date: live.date) + " " + live.artist + "\n"
            }
        }
    }
    
    public func shareSnsLiveInfo() {
        shareInfoManager.shareSnsLiveInfo(text: text)
    }
    
    public func addLive(live: Live) {
        lives.append(live)
        convertLiveInfoString()
    }
    
    public func removeLive(live: Live) {
        if let index = lives.firstIndex(of: live) {
            lives.remove(at: index)
            convertLiveInfoString()
        }
    }
    
    public func toggleFlag() {
        switchFlag.toggle()
        convertLiveInfoString()
    }
}
