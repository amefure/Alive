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
    
    public func convertLiveInfoString() {
        let df = DateFormatManager()
        text = ""
        for live in lives.sorted(by: { $0.date > $1.date}) {
            text = text + df.getShortString(date: live.date) + " " + live.artist + "\n"
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
}
